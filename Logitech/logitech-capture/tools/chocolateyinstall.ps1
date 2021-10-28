$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Logitech Capture*'
  fileType      = 'exe'
  silentArgs    = "/S"
  validExitCodes= @(0)
  url64bit      = "https://download01.logi.com/web/ftp/pub/techsupport/capture/Capture_2.06.12.exe"
  checksum64    = 'CDCE13ADB3F92C1461BCE6CBFEA9BA6B88AC438B3AF66BDBCB63FD98892B97DF'
  checksumType64= 'sha256'
  destination   = $toolsDir
}

Install-ChocolateyPackage @packageArgs