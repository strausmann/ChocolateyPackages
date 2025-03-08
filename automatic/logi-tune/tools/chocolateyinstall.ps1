$ErrorActionPreference = 'Stop';
$toolsDir     		   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://software.vc.logitech.com/downloads/tune/LogiTuneInstall.exe'
$checksum              = 'F8824885D8C5CC6512884985E72B24E84FE50DA62CD0AD8B9834E04B959A8E72'
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
