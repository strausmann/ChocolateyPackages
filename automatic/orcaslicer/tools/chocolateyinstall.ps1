$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName     = "OrcaSlicer\orca-slicer.exe"
$linkName     = "Orca Slicer.lnk"
$programs = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
$shortcutFilePath = Join-Path $programs $linkName
$targetPath   = Join-Path $toolsDir $fileName

$url                   = 'https://github.com/SoftFever/OrcaSlicer/releases/download/v2.3.0/OrcaSlicer_Windows_V2.3.0_portable.zip'
$checksum              = 'aa49c8e112a5c4483ff5025fc8f7087a65f63a8013810d50843c7c1fe66fc385'
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
