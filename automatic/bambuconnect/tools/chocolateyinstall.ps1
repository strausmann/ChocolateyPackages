$ErrorActionPreference = 'Stop'

$url64                 = 'https://public-cdn.bblmw.com/upgrade/bambu-connect/updates/versions/2.2.0-beta.1/bambu-connect-v2.2.0-beta.1-win32-x64.exe'
$checksum64            = 'c1750e3f83ee1a11fa550d24a05b347ccf7577a66bf8293a18d0538d46317208'
$checksumType64        = 'sha256'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Bambu Connect*'
  fileType       = 'exe'
  silentArgs     = ""  
  validExitCodes = @(0)
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = $checksumType64
}

Install-ChocolateyPackage @packageArgs
