$ErrorActionPreference = 'Stop';
$toolsDir     		   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://downloads.dell.com/serviceability/catalog/SupportAssistInstaller.exe'

#Based on Custom
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Dell SupportAssist'
  fileType      = 'exe'
  silentArgs    = "/S" 
  validExitCodes= @(0)
  url           = $url
  checksum      = ''
  checksumType  = 'sha256'
  url64bit      = ""
  checksum64    = ''
  checksumType64= 'sha256'
  destination   = $toolsDir
}

if (Get-IsWin10) {
	Install-ChocolateyPackage @packageArgs
} else {
	Write-Host "The installation is only possible on Windows 10 devices, other Windows client versions and Windows Servers are excluded." -ForegroundColor "Magenta" 
}