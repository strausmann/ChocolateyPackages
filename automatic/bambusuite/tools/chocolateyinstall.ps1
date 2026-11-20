$ErrorActionPreference = 'Stop'

$url                   = 'https://public-cdn.bblmw.com/general_pkg/prod/setup/20260922_143208_30/BambuSuite_Public_Win_01.05.00.00.exe'
$checksum              = 'd325fdc9e27b62ff19aa21c7b8d01226f763ff1be96fe9888418debc38412d86'
$ChecksumType          = 'sha256'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  softwareName          = 'Bambu Suite*'
  fileType              = 'exe'
  silentArgs            = "/VERYSILENT /NORESTART /RESTARTEXITCODE=3010 /SP- /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS /FORCECLOSEAPPLICATIONS /NOICONS"
  validExitCodes        = @(0, 3010, 1641)
  url                   = $url
  checksum              = $checksum
  checksumType          = $checksumType
}

Install-ChocolateyPackage @packageArgs
