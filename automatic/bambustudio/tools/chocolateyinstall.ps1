$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.01.62/Bambu_Studio_win_public-v01.07.01.62-20230801212357.exe'
$checksum              = '283404cb716f93244c279f2e335f9bd81bee3f951a437bf87cdd9cdb4f8d4524'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/bambulab/BambuStudio/releases/download/v01.07.01.62/Bambu_Studio_win_public-v01.07.01.62-20230801212357.exe'
$checksum64            = '283404cb716f93244c279f2e335f9bd81bee3f951a437bf87cdd9cdb4f8d4524'
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
