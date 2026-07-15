$ErrorActionPreference = 'Stop'

$url                   = 'https://public-cdn.bblmw.com/general_pkg/prod/setup/20260428_171731_302/BambuSuite_Public_Win_01.02.02.00.exe'
$checksum              = '37301fd958b301226dfb8197a2b2a54d50f88a6a6a91098d647e50c886486181'
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
