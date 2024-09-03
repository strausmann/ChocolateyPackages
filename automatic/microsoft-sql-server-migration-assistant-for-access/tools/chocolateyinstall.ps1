﻿$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_9.0.0_x86.msi'
$checksum              = '1bdae244909a47061bf39a616a6dbcc53eff338931c4a50367c748928eaae008'
$checksumType          = 'sha256'
$url64                 = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_9.0.0.msi'
$checksum64            = '4b7c0c087c776b46a0d31584b27d19cc9777cb323a10ee23cfd6ac188e477e91'
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