$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'

$url					= 'https://pkt.cash/PktWorldWalletSetup.exe'
$checksum				= '468796c53f21b537fc431aaefa45eaadf33f59e7aac47fe367fe71aaa1a53f09'
$checksumType           = 'sha256'

#Based on Custom
$packageArgs = @{
  packageName        = $env:ChocolateyPackageName
  installerType      = 'exe'
  softwareName       = 'Pkt.world Wallet*'
  silentArgs         = '/VERYSILENT'
  url                = $url
  checksum           = $checksum
  checksumType       = $checksumType
  url64              = $url64
  checksum64         = $checksum64
  checksumType64     = $checksumType64
  unzipLocation      = $toolsDir
  validExitCodes     = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs