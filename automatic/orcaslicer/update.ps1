Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$release = Get-GitHubRelease OrcaSlicer OrcaSlicer

function global:au_GetLatest {
  # OrcaSlicer publishes both arm64 and x64 Windows portable zips; without an
  # explicit arch filter '-First 1' can silently pick the arm64 asset
  # depending on GitHub's asset ordering (breaks on x64 machines).
  $Url32 = $release.assets | ? { $_.name -match 'Windows' -and $_.name -match 'x64' -and $_.name -like '*_portable.zip' } | Select-Object -First 1 -ExpandProperty browser_download_url

  $version = $release.tag_name.Trim('v')
  # Same upstream tag can still mean a different published artifact for us
  # (e.g. the arm64->x64 asset-selection fix above). Bump a synthetic fix
  # revision so AU re-publishes even though the upstream version string is
  # unchanged. NewChecksum is intentionally omitted here - the URL alone
  # already differs (arm64 vs x64), so there is no need to download+hash
  # the ~170 MB portable zip just to detect that.
  $version = Get-FixVersion -UpstreamVersion $version -NewUrl $Url32 -PackageDir $PSScriptRoot
  $ChecksumType = 'sha256'

  $tag = $release.tag_name
  $ReleaseNotes = "https://github.com/SoftFever/OrcaSlicer/releases/tag/$($tag)"

  @{
    Url32             = $Url32
    Version           = $version
    ChecksumType32    = $ChecksumType
    ReleaseNotes      = $ReleaseNotes
  }
}

function global:au_SearchReplace {
  @{
      'tools\chocolateyInstall.ps1' = @{
          "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.Url32)'"
          "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
          "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
      }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -key "releaseNotes" -value $Latest.ReleaseNotes
}

Update-Package -ChecksumFor 32
