$ErrorActionPreference = 'Stop'

$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                   = 'https://github.com/bambulab/BambuStudio/releases/download/v01.06.02.04/Bambu_Studio_win_public-v01.06.02.04-20230427094209.exe'
$checksum              = '9CD30DB8DF7A4D509063FD3617312780E30D3C8A6CD6E79689695BEAB04CB77D'
$ChecksumType          = 'sha256'
$url64                 = 'https://github.com/bambulab/BambuStudio/releases/download/v01.06.02.04/Bambu_Studio_win_public-v01.06.02.04-20230427094209.exe'
$checksum64            = '9CD30DB8DF7A4D509063FD3617312780E30D3C8A6CD6E79689695BEAB04CB77D'
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
