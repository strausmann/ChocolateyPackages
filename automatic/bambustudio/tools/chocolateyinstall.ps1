$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'BambuStudio.exe'

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.06.91/Bambu_Studio_win_public-v01.07.06.91-20230921105526.exe'
$checksum              = 'd268e54ba9b1c69886714b03b0215196e094e666e68f28168b96e5be84efe158'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.06.91/Bambu_Studio_win_public-v01.07.06.91-20230921105526.exe'
$checksum64            = 'd268e54ba9b1c69886714b03b0215196e094e666e68f28168b96e5be84efe158'
$ChecksumType64        = 'sha256'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  softwareName          = 'BambuStudio*'
  file                  = $fileLocation
  fileType              = 'exe'
  silentArgs            = "/S"
  validExitCodes        = @(0)
  url                   = $url
  url64                 = $url64
  checksum              = $checksum
  checksum64            = $checksum64
  checksumType          = $checksumType
  checksumType64        = $checksumType64
}

Install-ChocolateyPackage @packageArgs
