$ErrorActionPreference = 'Stop'

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v02.03.00.70/Bambu_Studio_win_public-v02.03.00.70-20251014214058.exe'
$checksum              = '0b0e6092f25f0d875e554d0657d9a1b5c753ec53b3063dca71b9d192669fc3ee'
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
