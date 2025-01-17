$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://public-cdn.bblmw.com/upgrade/bambu-connect/bambu-connect-beta-win32-x64-v1.0.4_4bb9cf0.exe'
$checksum              = '5A3F587211658C77FBA177D9C4193035520B75F9D2D6507C795599B7E05BCB4F'
$ChecksumType          = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Bambu Connect*'
  fileType      = 'exe'
  silentArgs    = ""  
  validExitCodes= @(0)
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
  destination   = $toolsDir
}

Install-ChocolateyInstallPackageCmdlet @packageArgs

