$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

#Based on Custom
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'teleport-cli*'
  fileType      = 'zip'
  silentArgs    = '' 
  validExitCodes= @(0)
  url           = ''
  checksum      = ''
  checksumType  = 'sha256'
  url64bit      = "https://cdn.teleport.dev/teleport-v11.0.1-windows-amd64-bin.zip"
  checksum64    = '9930FDD2D08717C46E38FC2F0E76ABEDDF02CE7F1980831124DAAB160CD741BC'
  checksumType64= 'sha256'
  destination   = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

#Get-ChocolateyUnzipCmdlet @packageArgs

