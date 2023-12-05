$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'BambuStudio.exe'

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v01.08.01.57/Bambu_Studio_win_public-v01.08.01.57-20231204180750.exe'
$checksum              = '3635053f82a0a349f4a9b0136c4cc36b21c9d21fb187f713ea14e08742109da8'
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
