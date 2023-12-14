$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'BambuStudio.exe'

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v01.08.02.56/Bambu_Studio_win_public-v01.08.02.56-20231214180334.exe'
$checksum              = '4ed3796bf69d1559b0ce6774393162f60629a03bf81ddbca8b5af62840cf6cb3'
$ChecksumType          = 'sha256'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  softwareName          = 'BambuStudio*'
  file                  = $fileLocation
  fileType              = 'exe'
  silentArgs            = "/S"
  validExitCodes        = @(0)
  url                   = $url
  checksum              = $checksum
  checksumType          = $checksumType
}

Install-ChocolateyPackage @packageArgs
