$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName     = "orca-slicer.exe"
$linkName     = "Orca Slicer.lnk"
$programs = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
$shortcutFilePath = Join-Path $programs $linkName
$targetPath   = Join-Path $toolsDir $fileName

$url                   = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v1.7.0-beta/OrcaSlicer_Windows_V1.7.0-beta_portable.zip'
$checksum              = 'a426ea01f103528c9de9e493347e20c2ae7337d9737e80753df38ac2c399265d'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v1.7.0-beta/OrcaSlicer_Windows_V1.7.0-beta_portable.zip'
$checksum64            = 'a426ea01f103528c9de9e493347e20c2ae7337d9737e80753df38ac2c399265d'
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
