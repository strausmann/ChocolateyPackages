$ErrorActionPreference = 'Stop'

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v02.06.00.51/Bambu_Studio_win-v02.06.00.51-20260417160415.exe'
$checksum              = 'c56df1dc1ddf84fab7b34caee71eecfb9db96c6785bf467faced8006ce375600'
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
