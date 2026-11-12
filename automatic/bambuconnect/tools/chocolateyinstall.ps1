$ErrorActionPreference = 'Stop'

$url64                 = 'https://public-cdn.bblmw.com/upgrade/bambu-connect/updates/versions/2.6.0-beta.0/bambu-connect-v2.6.0-beta.0-win32-x64.exe'
$checksum64            = '5b5a1b815e85b04182cac86ea0b7f7db585bafdf873d514633305fb3a93466f9'
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
