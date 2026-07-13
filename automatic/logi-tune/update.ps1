Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$releases = 'https://www.logitech.com/en-us/video-collaboration/software/logi-tune-software.html'

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
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  # Logitech offers both a standard (x64) and an "arm64" Windows installer on
  # this page. Neither the '\.exe' match nor -First 1 alone qualify by arch,
  # so the previous selection depended on DOM order and could silently pick
  # LogiTuneInstall-arm64.exe instead of LogiTuneInstall.exe (x64).
  $re = '\.exe'
  $Url32 = $download_page.Links | Where-Object { $_.href -match $re -and $_.href -notmatch '(?i)arm64' } | Select-Object -First 1 -ExpandProperty href

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
