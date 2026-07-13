$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'

$url					= 'https://install.speedtest.net/app/windows/latest/speedtestbyookla_x86.msi'
$checksum				= '15783895ae75387e14ca314837cdca96bef36a69a8923746ca31c78edf48b199'
$checksumType           = 'sha256'
$url64					= 'https://install.speedtest.net/app/windows/latest/speedtestbyookla_x64.msi'
$checksum64				= '281b9a15556ac2d1fb54b67fee260ea200266e31c70de9eceb82e04225c94d72'
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
