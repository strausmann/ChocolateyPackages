$ErrorActionPreference  = 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'
$url					= 'https://virt-manager.org/download/sources/virt-viewer/virt-viewer-x86-10.0-1.0.msi'
$url64					= 'https://virt-manager.org/download/sources/virt-viewer/virt-viewer-x64-10.0-1.0.msi'
$checksum				= 'ADA7D13136F8EC2CF574071AA0BC1C1B8CF14EE62614B0728CDCE5A46B080934'
$checksum64				= 'F50C13602060184B3E2DB5F5822FF1860AC2EEC39660578774008892E3516166'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'VirtViewer*'
  file          = $fileLocation
  fileType      = 'msi'
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`""
  validExitCodes= @(0,1641,3010)
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  destination   = $toolsDir
}

Install-ChocolateyPackage @packageArgs