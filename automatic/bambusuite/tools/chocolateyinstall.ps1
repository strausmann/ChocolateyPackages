$ErrorActionPreference = 'Stop'

$url                   = 'https://public-cdn.bblmw.com/general_pkg/prod/setup/20261103_152935_990/Bambu_Suite_Public_Win_01.06.00.00.exe'
$checksum              = '987bc405212f58ecb12566cabc83d4048656e2a0bf27e84e411f25a8155fa8b7'
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
