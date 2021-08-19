$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'ShareGate Desktop*'
  fileType      = 'MSI'
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`" SHAREGATEINSTALLSCOPE=PERUSER LAUNCHSHAREGATEONEXIT=0"
  validExitCodes= @(0,1641,3010)
  url           = "https://assets.sharegate.com/sharegate/desktop/downloads/Sharegate.15.0.6.msi"
  checksum      = 'ef44af175109d3ccba5954718e84e6ebabc9a8c9f30237042dc728174bb42b4d'
  checksumType  = 'sha256'
  url64bit      = "https://assets.sharegate.com/sharegate/desktop/downloads/Sharegate.15.0.6.msi"
  checksum64    = 'ef44af175109d3ccba5954718e84e6ebabc9a8c9f30237042dc728174bb42b4d'
  checksumType64= 'sha256'
  destination   = $toolsDir
}

if (Get-Is32) { 'url64bit', 'checksum64', 'checksumType64' | ForEach-Object { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs