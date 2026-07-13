# Export all the extensions that are meant to be used
# within a au update script here.

# We just specify the functions we want to export
# but the file containing the functions is expected
# to be named using the same name.
$funcs = @(
  'Get-GitHubRelease'
  'Get-MsiInformation'
  'Get-RedirectedUrl'
  'Set-DescriptionFromReadme'
  'Update-ChangelogVersion'
  'Update-OnETagChanged'
)

$funcs | % {
  if (Test-Path "$PSScriptRoot\$_.ps1") {
    . "$PSScriptRoot\$_.ps1"
    if (Get-Command $_ -ea 0) {
      Export-ModuleMember -Function $_
    }
  }
}

# ---------------------------------------------------------------------------
# Get-FixVersion (see comment-based help below).
#
# Kept directly in this module - instead of its own scripts\<Name>.ps1 file,
# the convention used by the functions loaded via $funcs above - to keep
# this change scoped to au_extensions.psm1 plus the au_GetLatest wiring in
# the consuming update.ps1.
# ---------------------------------------------------------------------------

function Get-FixVersionBase {
  <#
  .SYNOPSIS
     Internal helper for Get-FixVersion. Splits a version string into its
     first-3-segment "base" and, if present, a numeric 4th-segment
     revision (defaults to 0 when the 4th segment is absent).
  #>
  param([string] $VersionString)

  if ([string]::IsNullOrWhiteSpace($VersionString)) {
    return $null
  }

  $parts = $VersionString.Trim() -split '\.'
  if ($parts.Count -lt 3) {
    return $null
  }

  $revision = 0
  if ($parts.Count -ge 4 -and $parts[3] -match '^\d+$') {
    $revision = [int] $parts[3]
  }

  [pscustomobject]@{
    Base     = ($parts[0..2] -join '.')
    Revision = $revision
  }
}

function Get-FixVersionInstallVariable {
  <#
  .SYNOPSIS
     Internal helper for Get-FixVersion. Robustly reads a
     $name/$name64/$name32 = '...'-style assignment from a
     chocolateyinstall.ps1's raw content. Tries the 64-suffixed variable
     name first, then the 32-suffixed name, then the plain name, since
     packages use whichever depending on which ChecksumFor the
     au_SearchReplace block targets. Matching is case-insensitive since
     PowerShell variable names are case-insensitive.
  #>
  param(
    [string] $Content,
    [string] $Name
  )

  foreach ($candidate in @("$($Name)64", "$($Name)32", $Name)) {
    $pattern = '(?mi)^\s*\$' + [regex]::Escape($candidate) + '\s*=\s*([''"])(.*?)\1'
    $match = [regex]::Match($Content, $pattern)
    if ($match.Success) {
      return $match.Groups[2].Value
    }
  }

  return $null
}

<#
.SYNOPSIS
   Determine the version an AU package should publish for the current run,
   including a synthetic "fix revision" when the upstream version did not
   change but the resolved download artifact did.
.DESCRIPTION
   Chocolatey-AU's Update-Package only re-publishes a package when the
   candidate version returned by au_GetLatest is greater than the version
   already published (per the package's .nuspec). That is correct for real
   upstream releases, but it means a fix in *our* au_GetLatest logic (e.g.
   picking a different asset for the same upstream tag) is silently ignored
   forever, because the upstream version string never changes.

   Get-FixVersion compares the upstream version against the currently
   published version (nuspec) and, for a same-base-version case, against
   the currently published download URL (and optionally checksum) in
   tools\chocolateyinstall.ps1. If the artifact actually changed while the
   upstream version stayed the same, it returns a bumped 4th ("fix
   revision") segment so Update-Package treats it as newer and
   re-publishes. Otherwise it returns the upstream version unchanged, so
   normal AU semantics apply (update on a real new release, skip when
   nothing changed).

   "Base version" here means the first three segments of the upstream
   version scheme (e.g. 2.4.2 in both 2.4.2 and 2.4.2.1).

   The comparison is intentionally URL-first: comparing strings costs
   nothing, whereas verifying a checksum requires downloading the
   artifact. -NewChecksum is optional for the case where the URL is
   unchanged but the file behind it was swapped; callers that want that
   signal without paying for a full download on every run could look at
   caching the checksum keyed by the URL's ETag (not implemented here) and
   pass the cached value in.
.PARAMETER UpstreamVersion
   The version string reported by upstream for this run (e.g. the GitHub
   release tag with any leading 'v' trimmed). This is what au_GetLatest
   would normally return as $Latest.Version.
.PARAMETER NewUrl
   The download URL au_GetLatest resolved for this run (e.g. $Url32/$Url64).
.PARAMETER PackageDir
   Path to the package directory (typically $PSScriptRoot of the calling
   update.ps1). Used to locate the package's *.nuspec and
   tools\chocolateyinstall.ps1.
.PARAMETER NewChecksum
   Optional. The checksum au_GetLatest resolved for this run. Only used as
   an additional "did the artifact change" signal when the URL itself is
   unchanged; omit it to avoid downloading the artifact just to hash it.
.OUTPUTS
   [string] The version to use as $Latest.Version for this run.
.EXAMPLE
   $version = Get-FixVersion -UpstreamVersion $version -NewUrl $Url32 -PackageDir $PSScriptRoot

   Same upstream version, different URL than published -> returns e.g.
   '2.4.2.1' so Update-Package republishes. Same upstream version, same
   URL -> returns '2.4.2' unchanged so Update-Package skips (already
   published). Higher upstream version -> returns it unchanged (normal
   update).
#>
function Get-FixVersion {
  [CmdletBinding()]
  [OutputType([string])]
  param(
    [Parameter(Mandatory = $true)]
    [AllowEmptyString()]
    [string] $UpstreamVersion,

    [Parameter(Mandatory = $true)]
    [AllowEmptyString()]
    [string] $NewUrl,

    [Parameter(Mandatory = $true)]
    [string] $PackageDir,

    [Parameter(Mandatory = $false)]
    [string] $NewChecksum
  )

  if ([string]::IsNullOrWhiteSpace($NewUrl)) {
    # Nothing to compare against - behave like a normal update and let the
    # rest of the AU pipeline surface the real problem (missing asset).
    return $UpstreamVersion
  }

  $nuspecFile = Get-ChildItem -Path $PackageDir -Filter '*.nuspec' -File -ErrorAction SilentlyContinue | Select-Object -First 1
  if (-not $nuspecFile) {
    return $UpstreamVersion
  }

  $publishedVersionRaw = $null
  try {
    [xml] $nuspecXml = Get-Content -Path $nuspecFile.FullName -Raw
    $publishedVersionRaw = $nuspecXml.package.metadata.version
  } catch {
    Write-Warning "Get-FixVersion: could not parse '$($nuspecFile.FullName)': $($_.Exception.Message)"
    return $UpstreamVersion
  }

  $published = Get-FixVersionBase -VersionString $publishedVersionRaw
  $upstream = Get-FixVersionBase -VersionString $UpstreamVersion
  if (-not $published -or -not $upstream) {
    return $UpstreamVersion
  }

  try {
    $publishedBaseVersion = [version] $published.Base
    $upstreamBaseVersion = [version] $upstream.Base
  } catch {
    # Non-numeric version scheme (e.g. pre-release suffix) - can't compare
    # bases reliably, fall back to default AU behaviour.
    return $UpstreamVersion
  }

  if ($upstreamBaseVersion -gt $publishedBaseVersion) {
    return $UpstreamVersion
  }

  if ($upstreamBaseVersion -eq $publishedBaseVersion) {
    $installFile = Get-ChildItem -Path (Join-Path $PackageDir 'tools') -Filter 'chocolateyinstall.ps1' -File -ErrorAction SilentlyContinue | Select-Object -First 1

    $publishedUrl = $null
    $publishedChecksum = $null
    if ($installFile) {
      try {
        $installContent = Get-Content -Path $installFile.FullName -Raw -ErrorAction Stop
        $publishedUrl = Get-FixVersionInstallVariable -Content $installContent -Name 'url'
        $publishedChecksum = Get-FixVersionInstallVariable -Content $installContent -Name 'checksum'
      } catch {
        Write-Warning "Get-FixVersion: could not read or parse '$($installFile.FullName)': $($_.Exception.Message)"
      }
    }

    $urlChanged = [string]::IsNullOrEmpty($publishedUrl) -or ($NewUrl -ne $publishedUrl)
    $checksumChanged = $false
    if ($NewChecksum) {
      $checksumChanged = [string]::IsNullOrEmpty($publishedChecksum) -or ($NewChecksum -ne $publishedChecksum)
    }

    if ($urlChanged -or $checksumChanged) {
      return "$($published.Base).$($published.Revision + 1)"
    }
  }

  return $UpstreamVersion
}

Export-ModuleMember -Function Get-FixVersion
