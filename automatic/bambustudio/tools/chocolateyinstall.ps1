$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.02.51/Bambu_Studio_win_public-v01.07.02.51-20230804223010.exe'
$checksum              = '95d9500d7a6768c8e7f18b41ab7fc8844ee42ee5266b8a28707c3aab17467320'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.02.51/Bambu_Studio_win_public-v01.07.02.51-20230804223010.exe'
$checksum64            = '95d9500d7a6768c8e7f18b41ab7fc8844ee42ee5266b8a28707c3aab17467320'
$ChecksumType64        = 'sha256'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  fileFullPath          = "$toolsDir\BambuStudio.exe"
  url                   = $url
  url64                 = $url64
  checksum              = $checksum
  checksum64            = $checksum64
  checksumType          = $checksumType
  checksumType64        = $checksumType64
}

Get-ChocolateyWebFile @packageArgs
