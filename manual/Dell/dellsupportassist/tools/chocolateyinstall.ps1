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

Install-ChocolateyPackage @packageArgs