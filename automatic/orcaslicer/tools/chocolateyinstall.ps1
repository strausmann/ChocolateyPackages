$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName     = "orca-slicer.exe"
$linkName     = "Orca Slicer.lnk"
$programs = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
$shortcutFilePath = Join-Path $programs $linkName
$targetPath   = Join-Path $toolsDir $fileName

$url                   = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v1.8.0-beta2/OrcaSlicer_Windows_V1.8.0-beta2_portable.zip'
$checksum              = '34caa48360579a354a591adb6209c6528649e613188f1ae485a772193f69e034'
$ChecksumType          = 'sha256'

#Based on Custom
$packageArgs = @{
  fileType              = 'zip'
  packageName           = $env:ChocolateyPackageName
  fileFullPath          = "$toolsDir\OrcaSlicer.zip"
  url                   = $url
  checksum              = $checksum
  checksumType          = $checksumType
  destination           = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePath -targetPath $targetPath
