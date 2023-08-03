$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'
$url					= 'https://install.speedtest.net/app/windows/1.10.163/speedtestbyookla_x86.msi'
$checksum				= '934A5ED894432FADC07B7CCA9ED1BDC0B67F970E19D1E6E209BA35162FC9227B'
$url64					= 'https://install.speedtest.net/app/windows/1.10.163/speedtestbyookla_x64.msi'
$checksum64				= '0C4FC9E11056DBC5AC3FEC66F8CBFB5DEA9A327FEF3CBEA878C347B70D89DF30'

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