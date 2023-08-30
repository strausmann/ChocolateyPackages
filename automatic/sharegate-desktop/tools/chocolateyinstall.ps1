$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://assets.sharegate.com/sharegate/downloads/ShareGate.20.0.2.msi'
$checksum              = 'f2028928b14bf4d81efd7cf3b5cb1777a64a8903c4815a0853b80f49d6cf9f82'
$checksumType          = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'ShareGate migration tool*'
  fileType      = 'MSI'
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`" SHAREGATEINSTALLSCOPE=PERUSER LAUNCHSHAREGATEONEXIT=0"
  validExitCodes= @(0,1641,3010)
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
  url64bit      = $url
  checksum64    = $checksum
  checksumType64= $checksumType
  destination   = $toolsDir
}

if (Get-Is32) { 'url64bit', 'checksum64', 'checksumType64' | ForEach-Object { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs
