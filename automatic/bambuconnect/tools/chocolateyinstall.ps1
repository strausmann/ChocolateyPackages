$ErrorActionPreference = 'Stop'

$url64                 = 'https://public-cdn.bblmw.com/upgrade/bambu-connect/updates/versions/2.1.0-beta.4/bambu-connect-v2.1.0-beta.4-win32-x64.exe'
$checksum64            = '9163cb3fbd11e2213a8ebbc49a8f51c6821718d685242fe98ba88d8fa460ba0e'
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
