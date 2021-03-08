$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_8.17.0.msi'
$checksum              = '473398141b7823fa7d7c75e5330d6f62614bddf2d6e5135d152be8ba762ba1d1'

#Items that could be replaced based on what you call chocopkgup.exe with
#{{PackageName}} - Package Name (should be same as nuspec file and folder) |/p
#{{PackageVersion}} - The updated version | /v
#{{DownloadUrl}} - The url for the native file | /u
#{{PackageFilePath}} - Downloaded file if including it in package | /pp
#{{PackageGuid}} - This will be used later | /pg
#{{DownloadUrlx64}} - The 64-bit url for the native file | /u64
#{{Checksum}} - The checksum for the url | /c
#{{Checksumx64}} - The checksum for the 64-bit url | /c64
#{{ChecksumType}} - The checksum type for the url | /ct
#{{ChecksumTypex64}} - The checksum type for the 64-bit url | /ct64

#Based on Msi

$packageArgs = @{
	packageName    = $env:ChocolateyPackageName
	softwareName  = 'Microsoft SQL Server Migration Assistant for Access*'
	installerType  = 'MSI'
	url            = $url
	silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1 LICENSE_ACCEPTED=1"
	validExitCodes = @(0)
	checksum       = $checksum
	checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs

<#
== MSI Properties ==
These are the PROPERTIES of the MSI, some of which you can add or change to the silent args or add as package parameters
Note: This only captures what ends up in the MSI Property/AppSearch tables and is not guaranteed to cover all properties.


BROWSER=NULL
LICENSE_ACCEPTED=0
ALLUSERS=2
DISABLEADVTSHORTCUTS=1
SSMA_DIFFERENT_ARCHITECTURE_EXISTS=**Property found in SecureCustomProperties**
WIXNETFX4RELEASEINSTALLED=**Property found in SecureCustomProperties**
SSMA_OLDERVERSION_EXISTS=**Value is determined by MSI function**
OLEDB_PROVIDER_FOR_ACCESS=**Value is determined by MSI function**
REG_DISABLE_TELEMETRY=**Value is determined by MSI function**
REG_DISABLE_AUTO_UPDATE=**Value is determined by MSI function**
REG_USE_PREVIEW_CHANNEL=**Value is determined by MSI function**
LAUNCHBROWSERURL=**Value is used in MSI custom action LaunchBrowser**
#>