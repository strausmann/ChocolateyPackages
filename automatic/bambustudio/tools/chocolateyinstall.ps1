$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'BambuStudio.exe'

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.07.88/Bambu_Studio_win_public-v01.07.07.88-20231010083344.exe'
$checksum              = 'dfd00015ccda8a0b00c55f51796e4f03c174bd8a77e3c240be5cc55d79f9b694'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.07.88/Bambu_Studio_win_public-v01.07.07.88-20231010083344.exe'
$checksum64            = 'dfd00015ccda8a0b00c55f51796e4f03c174bd8a77e3c240be5cc55d79f9b694'
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
