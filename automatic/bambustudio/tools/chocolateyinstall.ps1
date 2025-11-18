$ErrorActionPreference = 'Stop'

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v02.04.00.70/Bambu_Studio_win_public-v02.04.00.70-20251118194119.exe'
$checksum              = '359d5d763121a5a0d287ef87d59d26aac5a0b7eb828a6fc5d87b276ec956fb85'
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
