$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = ''

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
}

Install-ChocolateyPackage @packageArgs