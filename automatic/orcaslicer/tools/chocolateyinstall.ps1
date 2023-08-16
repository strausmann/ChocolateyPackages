$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName     = "orca-slicer.exe"
$linkName     = "Orca Slicer.lnk"
$programs = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
$shortcutFilePath = Join-Path $programs $linkName
$targetPath   = Join-Path $toolsDir $fileName

$url                   = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v1.6.4-beta3/OrcaSlicer_Windows_V1.6.4-beta3.zip'
$checksum              = '4ec26f4dbbb4b3236a6fb87a80f1bca0e548a288320edf35818282928fe4233f'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v1.6.4-beta3/OrcaSlicer_Windows_V1.6.4-beta3.zip'
$checksum64            = '4ec26f4dbbb4b3236a6fb87a80f1bca0e548a288320edf35818282928fe4233f'
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
