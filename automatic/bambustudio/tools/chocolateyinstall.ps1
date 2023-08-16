$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.04.52/Bambu_Studio_win_public-v01.07.04.52-20230816204101.exe'
$checksum              = '65dfcd1f64cfad101f8e2a54585314ad1414005a7f41c05f25e6c8aa9063a85b'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.04.52/Bambu_Studio_win_public-v01.07.04.52-20230816204101.exe'
$checksum64            = '65dfcd1f64cfad101f8e2a54585314ad1414005a7f41c05f25e6c8aa9063a85b'
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
