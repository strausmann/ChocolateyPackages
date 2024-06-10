Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$release = Get-GitHubRelease bambulab BambuStudio

function GetResultInformation([string]$Url32) {
  $fileName = Split-Path -Leaf $Url32
  $dest = "$env:TEMP\$fileName"

  Get-WebFile $Url32 $dest | Out-Null

  $version         = (Get-Command $dest).FileVersionInfo.ProductVersion
  $ChecksumType    = 'sha256'
  $checksum32      = Get-FileHash $dest -Algorithm $checksumType | ForEach-Object Hash

  Remove-Item $dest -Force -ErrorAction SilentlyContinue

  @{
    Url32             = $Url32
    Version           = $version
	  Checksum32        = $checksum32
    ChecksumType32    = $ChecksumType
  }
}

function global:au_GetLatest {
  $Url32 = $release.assets | Where-Object {$_.name -match 'Bambu_Studio_win_public' } | Where-Object { $_.name.endswith('.exe') } | Select-Object -First 1 -ExpandProperty browser_download_url

  $version = $release.tag_name.Trim('v')
  $ChecksumType = 'sha256'

  $tag = $release.tag_name
  $ReleaseNotes = "https://github.com/bambulab/BambuStudio/releases/tag/$($tag)"

  Update-OnETagChanged -execUrl $Url32 -OnETagChanged { GetResultInformation $Url32 } -OnUpdated { @{ Url32 = $Url32 } }

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
