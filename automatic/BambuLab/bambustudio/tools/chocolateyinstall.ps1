$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Bambu Studio*'
  file          = ''
  fileType      = 'exe'
  silentArgs    = "/S"
  validExitCodes= @(0)
  url           = "https://public-cdn.bambulab.com/upgrade/studio/software/01.06.02.04/Bambu_Studio_win-v01.06.02.04.exe"
  checksum      = '9CD30DB8DF7A4D509063FD3617312780E30D3C8A6CD6E79689695BEAB04CB77D'
  checksumType  = 'sha256'
  url64bit      = "$url"
  checksum64    = "$checksum"
  checksumType64= 'sha256'
  destination   = $toolsDir
}

Install-ChocolateyPackage @packageArgs

