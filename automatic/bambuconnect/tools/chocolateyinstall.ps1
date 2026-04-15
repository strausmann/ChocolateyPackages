$ErrorActionPreference = 'Stop'

$url64                 = 'https://public-cdn.bblmw.com/upgrade/bambu-connect/updates/versions/2.4.0-beta.10/bambu-connect-v2.4.0-beta.10-win32-x64.exe'
$checksum64            = 'caf4af6c4884612ec6cfed07dfef12c56130e3b80abad3b2864d2799e1461bca'
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
