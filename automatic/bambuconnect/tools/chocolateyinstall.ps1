$ErrorActionPreference = 'Stop'

$url64                 = 'https://public-cdn.bblmw.com/upgrade/bambu-connect/updates/versions/2.1.1-beta.0/bambu-connect-v2.1.1-beta.0-win32-x64.exe'
$checksum64            = '46c962a90d82a77ee2305b725b0f09c3b41dd6a983f52c227e8a957e89e53eaa'
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
