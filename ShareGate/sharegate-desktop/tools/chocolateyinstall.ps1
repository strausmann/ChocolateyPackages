$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = ''

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
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'ShareGate Desktop*'
  fileType      = 'MSI'
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`" SHAREGATEINSTALLSCOPE=PERUSER LAUNCHSHAREGATEONEXIT=1"
  validExitCodes= @(0,1641,3010)
  url           = "https://assets.sharegate.com/sharegate/desktop/downloads/Sharegate.13.1.3.msi"
  checksum      = 'DECB5CAEFD22B2C423FF5E6E24FF5716A2819295C1B1BBF2850A91265F9DAE93'
  checksumType  = 'sha256'
  url64bit      = "https://assets.sharegate.com/sharegate/desktop/downloads/Sharegate.13.1.3.msi"
  checksum64    = 'DECB5CAEFD22B2C423FF5E6E24FF5716A2819295C1B1BBF2850A91265F9DAE93'
  checksumType64= 'sha256'
  destination   = $toolsDir
  #installDir   = "" # passed when you want to override install directory - requires licensed editions 1.9.0+
}

Install-ChocolateyPackage @packageArgs

<#
== MSI Properties ==
These are the PROPERTIES of the MSI, some of which you can add or change to the silent args or add as package parameters
Note: This only captures what ends up in the MSI Property/AppSearch tables and is not guaranteed to cover all properties.


LAUNCHSHAREGATEONEXIT=1
SHAREGATETARGETEXECUTABLE=Sharegate.exe
CLICKONCEAPPNAME=ShareGate Desktop
PRODUCTNAMESTOUNINSTALL=ShareGate Desktop;Sharegate Migration
NEWERFOUND=**Property found in SecureCustomProperties**
OLDAPPFOUND=**Property found in SecureCustomProperties**
PREVIOUSFOUND=**Property found in SecureCustomProperties**
WIXNETFX4RELEASEINSTALLED=**Property found in SecureCustomProperties**
APPLICATIONFOLDER=**Value is used in MSI custom action SetPathForUninstall**
#>