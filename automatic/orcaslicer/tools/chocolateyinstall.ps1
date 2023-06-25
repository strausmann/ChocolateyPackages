$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName     = "orca-slicer.exe"
$linkName     = "Orca Slicer.lnk"
$programs = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
$shortcutFilePath = Join-Path $programs $linkName
$targetPath   = Join-Path $toolsDir $fileName

#Based on Custom
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'orcaslicer*'
  file          = ""
  fileType      = 'zip'
  silentArgs    = ""
  validExitCodes= @(0)
  url           = "https://github.com/SoftFever/OrcaSlicer/releases/download/v1.6.3/OrcaSlicer_V1.6.3_Win64.zip"
  checksum      = '39A69BD16591BE80F4F77E01F0FED8596C6466D96ED560E1A7236CACFE7B6B8E'
  checksumType  = 'sha256'
  url64bit      = "$url"
  checksum64    = '$checksum'
  checksumType64= 'sha256'
  destination   = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePath -targetPath $targetPath