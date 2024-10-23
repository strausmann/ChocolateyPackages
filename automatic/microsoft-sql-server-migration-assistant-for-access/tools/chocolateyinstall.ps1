$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_10.0.0_x86.msi'
$checksum              = '92419568d8cd08b6e08005ceb2ac23802c215424349833cb9ea36c790f731e5d'
$checksumType          = 'sha256'
$url64                 = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_10.0.0.msi'
$checksum64            = '41c941c9f9f2da5c63030d4608fc6829f109273654558e740a724a0bb048261c'
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
