$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'

$url					= 'https://install.speedtest.net/app/windows/1.13.194/speedtestbyookla_x86.msi'
$checksum				= '6563db0c4ac93250d899ec0cee7b75288e0f09c0d1ce65413e18fcfd0c1c143d'
$checksumType           = 'sha256'
$url64					= 'https://install.speedtest.net/app/windows/1.13.194/speedtestbyookla_x64.msi'
$checksum64				= 'b2f69cc7c8fcf6038a7f76773732f12268ad58c46b7164afb4475ac35afc2b5d'
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
