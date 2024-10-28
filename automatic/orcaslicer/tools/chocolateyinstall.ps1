$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName     = "OrcaSlicer\orca-slicer.exe"
$linkName     = "Orca Slicer.lnk"
$programs = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
$shortcutFilePath = Join-Path $programs $linkName
$targetPath   = Join-Path $toolsDir $fileName

$url                   = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v2.2.0/OrcaSlicer_Windows_V2.2.0_portable.zip'
$checksum              = '232ef32ec4efba132525b7c4c0c131829ef231317d47bc2623d87021ce8c2684'
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
