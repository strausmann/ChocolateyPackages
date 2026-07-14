Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$release = Get-GitHubRelease fosrl newt

function global:au_GetLatest {
  # GitHub-API kann (Rate-Limit auf geteilter CI-IP) leer zurueckkommen. Dann NICHT
  # mit leerer Version failen, sondern die aktuelle nuspec-Version behalten, damit
  # [PUSH]/choco pack weiterlaufen (Url/Checksum stehen fest in chocolateyinstall.ps1).
  if (-not $release -or [string]::IsNullOrWhiteSpace($release.tag_name)) {
    Write-Warning 'Get-GitHubRelease returned no data (GitHub API rate limit?) - keeping current nuspec version.'
    $nuspecPath = Join-Path $PSScriptRoot 'pangolin-newt.portable.nuspec'
    if (-not (Test-Path -LiteralPath $nuspecPath)) { $nuspecPath = 'pangolin-newt.portable.nuspec' }
    # Regex statt [xml]: die nuspec hat einen Default-Namespace, an dem .package.metadata.version scheitert.
    $currentVersion = ([regex]::Match((Get-Content -Raw -LiteralPath $nuspecPath), '<version>\s*([^<\s]+)')).Groups[1].Value
    return @{ Version = $currentVersion }
  }

  $version = $release.tag_name
  $asset = $release.assets | Where-Object { $_.name -match 'newt_windows_amd64\.exe' } | Select-Object -First 1
  $Url64 = $asset.browser_download_url

  return @{
    Version = $version
    Url64   = $Url64
  }
}

function global:au_BeforeUpdate {
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.Url64 -Algorithm 'sha256'
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.Url64)'"
      "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

if ($MyInvocation.InvocationName -ne '.') { Update-Package -ChecksumFor none }  # dot-source-fest: laeuft nur bei direktem Aufruf
