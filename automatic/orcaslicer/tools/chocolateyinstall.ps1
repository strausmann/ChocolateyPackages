$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName     = "orca-slicer.exe"
$linkName     = "Orca Slicer.lnk"
$programs = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
$shortcutFilePath = Join-Path $programs $linkName
$targetPath   = Join-Path $toolsDir $fileName

$url                   = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v1.6.4-beta/OrcaSlicer_V1.6.4-beta_Win64.zip'
$checksum              = 'dd49e47e36d7802b0a2a973394e275226d68eef7e9a70a0eab2300119e5436ef'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v1.6.4-beta/OrcaSlicer_V1.6.4-beta_Win64.zip'
$checksum64            = 'dd49e47e36d7802b0a2a973394e275226d68eef7e9a70a0eab2300119e5436ef'
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
