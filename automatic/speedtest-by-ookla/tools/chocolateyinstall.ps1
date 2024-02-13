$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'

$url					= 'https://install.speedtest.net/app/windows/1.12.186/speedtestbyookla_x86.msi'
$checksum				= '28e4e18f82a95bad8cd7547318618b25349443c7373804f54518788d967426c6'
$checksumType           = 'sha256'
$url64					= 'https://install.speedtest.net/app/windows/1.12.186/speedtestbyookla_x64.msi'
$checksum64				= '87e528a644575a4774111d5694dc50ac4962abf50ad7b26c585a14820090a181'
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
