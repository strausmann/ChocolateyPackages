$ErrorActionPreference = 'Stop'

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v02.07.01.57/Bambu_Studio_win-v02.07.01.57-20260601165745.exe'
$checksum              = '2960254c538d71ca3f9deeb5982fa18b357998aaa69f697bf5b8d4e9f199c494'
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
