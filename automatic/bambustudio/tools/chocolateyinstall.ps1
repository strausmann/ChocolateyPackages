$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v01.10.02.76/Bambu_Studio_win_public-v01.10.02.76-20250225202310.exe'
$checksum              = 'b26ae1c644e8974b7d87b6d5ba40b1010200c2d4b894f4e074a88bf833e25ad3'
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
