$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_8.22.0_x86.msi'
$checksum              = 'db05bbdbba58aaa0ad2e9af8d87786b9c86548dd8249110cc3970cfe18dd68e8'
$urlx64                = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_8.22.0.msi'
$checksumx64           = 'f7f6c10d3173042e83ce69a4db77cd1a57577fa9b54af828a74215636a198307'

$packageArgs = @{
	packageName    = $env:ChocolateyPackageName
	softwareName   = 'Microsoft SQL Server Migration Assistant for Access*'
	installerType  = 'MSI'
	url            = $url
	url64bit       = $urlx64
	silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1 LICENSE_ACCEPTED=1"
	validExitCodes = @(0,1641,3010)
	checksum       = $checksum
	checksumType   = 'sha256'
	Checksum64     = $checksumx64
	ChecksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs