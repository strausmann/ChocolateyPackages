$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'SSMAforAccess_8.17.0.msi'

#Based on Msi
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Microsoft SQL Server Migration Assistant for Access*'
  file          = $fileLocation
  fileType      = 'msi'
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`" ALLUSERS=1 LICENSE_ACCEPTED=1"
  validExitCodes= @(0,1641,3010)
  url           = ""
  checksum      = '473398141B7823FA7D7C75E5330D6F62614BDDF2D6E5135D152BE8BA762BA1D1'
  checksumType  = 'sha256'
  url64bit      = ""
  checksum64    = ''
  checksumType64= 'sha256'
  destination   = $toolsDir
  #installDir   = "" # passed when you want to override install directory - requires licensed editions 1.9.0+
}

Install-ChocolateyInstallPackage @packageArgs

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

