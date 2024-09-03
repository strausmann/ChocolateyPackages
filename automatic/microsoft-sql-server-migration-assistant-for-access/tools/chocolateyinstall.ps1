$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_9.5.0_x86.msi'
$checksum              = '2d257459d1dca3503c790317fc4a178d530b5c4550dc44628d7c35ec7cd7acab'
$checksumType          = 'sha256'
$url64                 = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_9.5.0.msi'
$checksum64            = 'b97e956d33385e8e9fa520822578c24d1180297963990455b2e80d164f47a7be'
$checksumType64        = 'sha256'

$packageArgs = @{
	packageName    = $env:ChocolateyPackageName
	softwareName   = 'Microsoft SQL Server Migration Assistant for Access*'
	installerType  = 'MSI'
	url            = $url
	url64bit       = $url64
	silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1 LICENSE_ACCEPTED=1"
	validExitCodes = @(0,1641,3010)
	checksum       = $checksum
	checksumType   = $checksumType
	Checksum64     = $checksum64
	ChecksumType64 = $checksumType64
}

Install-ChocolateyPackage @packageArgs
