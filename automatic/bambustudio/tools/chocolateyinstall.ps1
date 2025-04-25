$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/V02.00.03.54/Bambu_Studio_win_public-v02.00.03.54-20250424182834.exe'
$checksum              = '2f2bc654c07553b2e1157cfc7f61a87c87fce5d534a0c4ec94cb9eb1b65d8d19'
$ChecksumType          = 'sha256'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  softwareName          = 'BambuStudio*'
  fileType              = 'exe'
  silentArgs            = "/S"
  validExitCodes        = @(0)
  url                   = $url
  checksum              = $checksum
  checksumType          = $checksumType
}

Install-ChocolateyPackage @packageArgs
