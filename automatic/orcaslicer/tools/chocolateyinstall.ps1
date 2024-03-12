$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName     = "OrcaSlicer\orca-slicer.exe"
$linkName     = "Orca Slicer.lnk"
$programs = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
$shortcutFilePath = Join-Path $programs $linkName
$targetPath   = Join-Path $toolsDir $fileName

$url                   = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v2.0.0-beta/OrcaSlicer_Windows_V2.0.0-beta_portable.zip'
$checksum              = '4829f52d38f159a59c9225f1e31ca5821bc12774ae1320845c782965da82f5db'
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
