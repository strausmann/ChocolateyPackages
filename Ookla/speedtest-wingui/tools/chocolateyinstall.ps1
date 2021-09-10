$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'speedtestbyookla_x64.msi'

#Based on Msi
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Speedtest by Ookla*'
  file          = $fileLocation
  fileType      = 'msi'
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`""
  validExitCodes= @(0,1641,3010)
  url           = ""
  checksum      = '1DD23AE6D330EF6BB650C2420A0D5AE87023D5D88B9CB37A5FED4BEA0403A72D'
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


OLDPRODUCTS=**Property found in SecureCustomProperties**
AI_NEWERPRODUCTFOUND=**Property found in SecureCustomProperties**
AI_BITMAP_DISPLAY_MODE=0
AI_PATH_VALIDATION_OPT=2
ALLUSERS=1
CTRLS=2
RUNAPPLICATION=1
INSTALLLEVEL=3
PROMPTROLLBACKCOST=P
AI_CF_TITLE_TEXT_STYLE={\CfTitleFont}
AI_LOG_CHECKBOX=1
AI_BUILD_NAME=DefaultBuild
AI_PACKAGE_TYPE=x64
AI_BOOTSTRAPPER_OPTIONS=o
AI_APP_FILE=[#Speedtest.exe]
AI_PREREQS_DIR=[AppDataFolder]Ookla\Speedtest by Ookla\prerequisites
AI_BOOTSTRAPPERLANGS=1033;1025;1028;2052;1043;1036;1031;1057;1040;1041;1042;1045;2070;1049;3082;1053;
AI_BOOTSTRAPPERORIGINALLANG=1033
AI_EMBEDDED_FILES_LOCATION=1
APPDIR=**Value is used in MSI custom action SET_TARGETDIR_TO_APPDIR**
#>

