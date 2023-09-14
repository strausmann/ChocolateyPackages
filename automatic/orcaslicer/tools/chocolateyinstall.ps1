$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName     = "orca-slicer.exe"
$linkName     = "Orca Slicer.lnk"
$programs = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
$shortcutFilePath = Join-Path $programs $linkName
$targetPath   = Join-Path $toolsDir $fileName

$url                   = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v1.7.0/OrcaSlicer_Windows_V1.7.0_portable.zip'
$checksum              = '4d31605c6688193a6dc54155b66056208d66929bfc0c85f61f9ff9092a9d3eab'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v1.7.0/OrcaSlicer_Windows_V1.7.0_portable.zip'
$checksum64            = '4d31605c6688193a6dc54155b66056208d66929bfc0c85f61f9ff9092a9d3eab'
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
