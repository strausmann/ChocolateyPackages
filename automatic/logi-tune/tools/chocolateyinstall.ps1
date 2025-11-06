$ErrorActionPreference = 'Stop';
$toolsDir     		   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://software.vc.logitech.com/downloads/tune/LogiTuneInstall.exe'
$checksum              = '0AA1281CC2019687A446D26FE93D1C6070A08E0DF8419CC98D87E331A0D7B474'
$checksumType          = 'sha256'

#Based on Custom
$packageArgs = @{
  packageName        = $env:ChocolateyPackageName
  unzipLocation      = $toolsDir
  fileType           = 'exe'
  softwareName       = "Logi Tune*"
  silentArgs         = "/S"
  url                = $url
  checksum           = $checksum
  checksumType       = $checksumType
  url64              = $url
  checksum64         = $checksum
  checksumType64     = $checksumType
  validExitCodes     = @(0, 3010, 1641)
}

# operating system check
$WindowsVersion=[Environment]::OSVersion.Version
if ($WindowsVersion.Major -ne "10") {
  throw "This package requires Windows 10 or Windows 11."
}

Install-ChocolateyPackage @packageArgs
