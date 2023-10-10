Import-Module AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$release = Get-GitHubRelease SoftFever OrcaSlicer

function global:au_GetLatest {
  $Url32 = $release.assets | ? {$_.name -match 'Windows' } | ? { $_.name.endswith('_portable.zip') } | select -First 1 -ExpandProperty browser_download_url

  $version = $release.tag_name.Trim('v')
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
