$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'
$url					= 'https://install.speedtest.net/app/windows/1.9.159/speedtestbyookla_x86.msi'
$checksum				= '5B231DB7F1F439920124092AAB3DB1F801BD5ADD1A061C8A1A74E9EFCE27946F'
$url64					= 'https://install.speedtest.net/app/windows/1.9.159/speedtestbyookla_x64.msi'
$checksum64				= '1DD23AE6D330EF6BB650C2420A0D5AE87023D5D88B9CB37A5FED4BEA0403A72D'

$packageArgs = @{
	packageName    = $env:ChocolateyPackageName
	softwareName  = 'Speedtest by Ookla*'
	installerType  = 'msi'
	url            = $url
	checksum       = $checksum
	checksumType   = 'sha256'
	url64bit       = $url64
	checksum64     = $checksum64
	checksumType64 = 'sha256'
	silentArgs    = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`""
	validExitCodes= @(0,1641,3010)
}

Install-ChocolateyPackage @packageArgs