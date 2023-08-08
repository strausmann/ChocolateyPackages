$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.03.50/Bambu_Studio_win_public-v01.07.03.50-20230808103800.exe'
$checksum              = 'd26bbedc61f7a16fdd5ad43b77e2f6ce710ea22957ea4684b09c362f4d8b729e'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.03.50/Bambu_Studio_win_public-v01.07.03.50-20230808103800.exe'
$checksum64            = 'd26bbedc61f7a16fdd5ad43b77e2f6ce710ea22957ea4684b09c362f4d8b729e'
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
