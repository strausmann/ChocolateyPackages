$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v02.00.00.95/Bambu_Studio_win_public-v02.00.00.95-20250325211800.exe'
$checksum              = 'fd177a6017964ec9a308cb075147256a1d66fc03ebcffe74e26074b733e2f9b4'
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
