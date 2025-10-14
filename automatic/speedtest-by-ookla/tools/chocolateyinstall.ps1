$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'

$url					= 'https://install.speedtest.net/app/windows/1.14.198/speedtestbyookla_x86.msi'
$checksum				= '564c2d5eebd211eead252181177450477fcf69ecd4e423be36c69ad2839477ab'
$checksumType           = 'sha256'
$url64					= 'https://install.speedtest.net/app/windows/1.14.198/speedtestbyookla_x64.msi'
$checksum64				= '7de3cae488213149cc7d1bde9e06bef51b20649b424722a50a02a01f435b05c3'
$checksumType64         = 'sha256'

#Based on Custom
$packageArgs = @{
  packageName        = $env:ChocolateyPackageName
  installerType      = 'msi'
  softwareName       = "Speedtest by Ookla*"
  silentArgs         = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`""
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
