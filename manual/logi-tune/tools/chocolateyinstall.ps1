$ErrorActionPreference = 'Stop';
$toolsDir     		   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://software.vc.logitech.com/downloads/tune/LogiTuneInstall.exe'
$checksum              = '831D6A69BFD6195EA840F43D513646C71D9496CD1A1E983ED56D3E47CA8F37FE'
$urlx64                = 'https://software.vc.logitech.com/downloads/tune/LogiTuneInstall.exe'
$checksumx64           = '831D6A69BFD6195EA840F43D513646C71D9496CD1A1E983ED56D3E47CA8F37FE'

#Based on Custom
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Logi Tune*'
  fileType      = 'exe'
  silentArgs    = "/S"
  validExitCodes= @(0)
  url           = $url
  checksum      = $checksum
  checksumType  = "sha256"
  url64bit      = $urlx64
  checksum64    = $checksumx64
  checksumType64= "sha256"
  destination   = $toolsDir
}

Install-ChocolateyPackage @packageArgs