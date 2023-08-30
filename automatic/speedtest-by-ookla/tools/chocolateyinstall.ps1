$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'

$url					= 'https://install.speedtest.net/app/windows/1.11.165/speedtestbyookla_x86.msi'
$checksum				= 'f7c64456c2a6b9a934734e385758f83f70aac8552c2cbee70bf0f01abfddcee1'
$checksumType           = 'sha256'
$url64					= 'https://install.speedtest.net/app/windows/1.11.165/speedtestbyookla_x64.msi'
$checksum64				= 'e12ccf3aa0f0a81870402d5dff6639eb2a7b30ffd367decd2b48ca1c80429f43'
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
