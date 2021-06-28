$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'ShareGate Desktop*'
  fileType      = 'MSI'
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`" SHAREGATEINSTALLSCOPE=PERUSER LAUNCHSHAREGATEONEXIT=0"
  validExitCodes= @(0,1641,3010)
  url           = "https://assets.sharegate.com/sharegate/desktop/downloads/Sharegate.15.0.1.msi"
  checksum      = '8e20192d16f0481e973400d277c5841404fb713460b27931e1b5752862e7635b'
  checksumType  = 'sha256'
  url64bit      = "https://assets.sharegate.com/sharegate/desktop/downloads/Sharegate.15.0.1.msi"
  checksum64    = '8e20192d16f0481e973400d277c5841404fb713460b27931e1b5752862e7635b'
  checksumType64= 'sha256'
  destination   = $toolsDir
}

if (Get-Is32) { 'url64bit', 'checksum64', 'checksumType64' | ForEach-Object { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs