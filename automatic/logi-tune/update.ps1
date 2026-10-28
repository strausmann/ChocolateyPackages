Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

# Stable direct download of the x64 Windows installer. The product page used to list it,
# but since 10/2026 it redirects to /business/video-collaboration/logi-tune and only
# renders the macOS .dmg server-side, so page scraping returned no .exe link at all.
$Url32 = 'https://software.vc.logitech.com/downloads/tune/LogiTuneInstall.exe'

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
  # Version and checksum come from the downloaded file; the ETag avoids re-downloading
  # the ~200 MB installer when nothing changed.
  Update-OnETagChanged -execUrl $Url32 -OnETagChanged { GetResultInformation $Url32 } -OnUpdated { @{ Url32 = $Url32 } }
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

Update-Package -ChecksumFor 32
