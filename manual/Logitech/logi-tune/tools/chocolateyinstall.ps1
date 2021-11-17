$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

#Based on Custom
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Logi Tune*'
  file          = ''
  fileType      = 'exe'
  silentArgs    = "/S"
  validExitCodes= @(0)
  url           = ""
  checksum      = ""
  checksumType  = ""
  url64bit      = "https://software.vc.logitech.com/downloads/tune/LogiTuneInstall.exe"
  checksum64    = '831D6A69BFD6195EA840F43D513646C71D9496CD1A1E983ED56D3E47CA8F37FE'
  checksumType64= 'sha256'
  destination   = $toolsDir
}

Install-ChocolateyInstallPackage @packageArgs