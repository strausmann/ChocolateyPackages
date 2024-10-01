$ErrorActionPreference = 'Stop';
$toolsDir     		   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://software.vc.logitech.com/downloads/tune/LogiTuneInstall.exe'
$checksum              = '71DC624CDA36DDBC9037FB445D9724EACCFE9C811EB4CDA5F47F8768B8585C39'
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
