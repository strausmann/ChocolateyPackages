$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName     = "orca-slicer.exe"
$linkName     = "Orca Slicer.lnk"
$programs = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
$shortcutFilePath = Join-Path $programs $linkName
$targetPath   = Join-Path $toolsDir $fileName

$url                   = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v1.6.4/OrcaSlicer_Windows_V1.6.4_portable.zip'
$checksum              = 'c3b74916315598ad65f7530b0782dd44c1fb27000b83b7187853838f40b172f9'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v1.6.4/OrcaSlicer_Windows_V1.6.4_portable.zip'
$checksum64            = 'c3b74916315598ad65f7530b0782dd44c1fb27000b83b7187853838f40b172f9'
$ChecksumType64        = 'sha256'

#Based on Custom
$packageArgs = @{
  fileType              = 'zip'
  packageName           = $env:ChocolateyPackageName
  fileFullPath          = "$toolsDir\OrcaSlicer.zip"
  url                   = $url
  url64                 = $url64
  checksum              = $checksum
  checksum64            = $checksum64
  checksumType          = $checksumType
  checksumType64        = $checksumType64
  destination           = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePath -targetPath $targetPath
