$ErrorActionPreference = 'Stop'

$url                   = 'https://public-cdn.bblmw.com/general_pkg/prod/setup/20260601_205006_680/BambuSuite_Public_Win_01.03.00.00.exe'
$checksum              = '4664e8542664ac8c73f6f647b21018001bff8f2f8bcb1015139ea20945d46008'
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
