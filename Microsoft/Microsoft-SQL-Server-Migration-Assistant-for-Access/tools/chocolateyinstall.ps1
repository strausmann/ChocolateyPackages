$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_8.21.0_x86.msi'
$checksum              = 'ae9d6f1afd2365902c32d957d82ea5f78cf8b1ae42fb63a2b6780a91af3047a4'
$urlx64                = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_8.21.0.msi'
$checksumx64           = 'b07cf203495080549d7b59c8b7b9ead0b50d2b85dfd320fec6b0a9e52283fe42'

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