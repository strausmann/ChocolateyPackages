$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Dell Command | Monitor*'
  fileType      = 'exe'
  silentArgs    = "/s"
  validExitCodes= @(0,1641,3010)
  url           = "https://dl.dell.com/FOLDER07462014M/3/Dell-Command-Monitor_DG3NG_WIN_10.5.1.114_A00_01.EXE"
  checksum      = '198d4f8e823a4c34502644f022b48f42'
  checksumType  = 'md5'
  url64bit      = "https://dl.dell.com/FOLDER07462032M/3/Dell-Command-Monitor_6R88F_WIN_10.5.1.114_A00_02.EXE"
  checksum64    = 'ccbe7a2b38e280a10854c612fbcf2ae4'
  checksumType64= 'md5'
  destination   = $toolsDir
}

Install-ChocolateyPackage @packageArgs