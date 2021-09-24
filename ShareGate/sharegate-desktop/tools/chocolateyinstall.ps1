$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'ShareGate Desktop*'
  fileType      = 'MSI'
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`" SHAREGATEINSTALLSCOPE=PERUSER LAUNCHSHAREGATEONEXIT=0"
  validExitCodes= @(0,1641,3010)
  url           = "https://assets.sharegate.com/sharegate/desktop/downloads/Sharegate.15.1.2.msi"
  checksum      = 'e1a8a72fc926eb33f5b2d279f2c79ec458d4b42106a5060210a00c063e838984'
  checksumType  = 'sha256'
  url64bit      = "https://assets.sharegate.com/sharegate/desktop/downloads/Sharegate.15.1.2.msi"
  checksum64    = 'e1a8a72fc926eb33f5b2d279f2c79ec458d4b42106a5060210a00c063e838984'
  checksumType64= 'sha256'
  destination   = $toolsDir
}

if (Get-Is32) { 'url64bit', 'checksum64', 'checksumType64' | ForEach-Object { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs