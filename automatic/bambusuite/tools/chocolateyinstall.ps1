$ErrorActionPreference = 'Stop'

$url                   = 'https://public-cdn.bblmw.com/general_pkg/prod/setup/20260812_162517_473/BambuSuite_Public_Win_01.04.00.00.exe'
$checksum              = '5eb59d7f04614edff2d780181c7ef52363184ab16577f417129c35f380435e32'
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
