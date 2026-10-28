$ErrorActionPreference = 'Stop';

$url64      = 'https://github.com/fosrl/cli/releases/download/0.19.1/pangolin-cli_windows_installer.msi'
$checksum64 = '7c3dc9ac8cf3d25cf3b6d57173d120f7449211fc94c1778762d71e42b62aad7b'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  softwareName   = 'Pangolin CLI*'
  silentArgs     = '/quiet'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
