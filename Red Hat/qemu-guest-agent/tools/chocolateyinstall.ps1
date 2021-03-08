$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'virtio-win-gt-x86.msi'
$fileLocation64 = Join-Path $toolsDir 'virtio-win-gt-x64.msi'
if (Get-ProcessorBits 64) {
$forceX86 = $env:chocolateyForceX86
  if ($forceX86 -eq 'true') {
    Write-Debug "User specified '-x86' so forcing 32-bit"
  } else {
    $fileLocation = $fileLocation64
  }
}

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
  softwareName  = 'Virtio-win-guest-tools*'
  file          = $fileLocation
  fileType      = 'msi'
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`""
  validExitCodes= @(0,1641,3010)
  url           = ""
  checksum      = '104FB184567A47C23E26C14C156B88EA1AF69DE52A8D5B9AC71C64855A094504'
  checksumType  = 'sha256'
  url64bit      = ""
  checksum64    = '0A937D11210ECF87E5C00F0C0AAA7BC643CAC44C42DAC31137375B59A64FF6F4'
  checksumType64= 'sha256'
  destination   = $toolsDir
  #installDir   = "" # passed when you want to override install directory - requires licensed editions 1.9.0+
}

Install-ChocolateyInstallPackage @packageArgs

<#
== MSI Properties ==
These are the PROPERTIES of the MSI, some of which you can add or change to the silent args or add as package parameters
Note: This only captures what ends up in the MSI Property/AppSearch tables and is not guaranteed to cover all properties.


ALLUSERS=1
1=**Property found in Set_oVirt_Agent_Properties**
REGISTRY_PRODUCT_NAME=**Value is determined by MSI function**
REGISTRYSEARCH_IS_TERMSERVICE_EXIST=**Value is determined by MSI function**
REGISTRYSEARCH_IS_SPICEUSBREDIRECTOR_EXIST=**Value is determined by MSI function**
REGISTRYSEARCH_OLD_WGT_UNINSTALL_PATH=**Value is determined by MSI function**
#>

