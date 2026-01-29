$ErrorActionPreference = 'Stop'

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v02.05.00.67/Bambu_Studio_win_public-v02.05.00.66-20260128215914.exe'
$checksum              = 'fab33011933f6807a7694c4edc0ddb84362d789b5e8974ea01042ed6eadbefb9'
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
