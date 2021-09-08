$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'ShareGate Desktop*'
  fileType      = 'MSI'
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`" SHAREGATEINSTALLSCOPE=PERUSER LAUNCHSHAREGATEONEXIT=0"
  validExitCodes= @(0,1641,3010)
  url           = "https://assets.sharegate.com/sharegate/desktop/downloads/Sharegate.15.1.1.msi"
  checksum      = '64f28ef74467dc00e5196c2e202994c84aaaa07aefca71c44298bb94233161ba'
  checksumType  = 'sha256'
  url64bit      = "https://assets.sharegate.com/sharegate/desktop/downloads/Sharegate.15.1.1.msi"
  checksum64    = '64f28ef74467dc00e5196c2e202994c84aaaa07aefca71c44298bb94233161ba'
  checksumType64= 'sha256'
  destination   = $toolsDir
}

if (Get-Is32) { 'url64bit', 'checksum64', 'checksumType64' | ForEach-Object { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs