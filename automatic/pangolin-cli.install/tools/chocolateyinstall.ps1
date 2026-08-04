$ErrorActionPreference = 'Stop';

$url64      = 'https://github.com/fosrl/cli/releases/download/0.15.1/pangolin-cli_windows_installer.msi'
$checksum64 = 'e909892ce603e2ab58ae431eafd6c938317a2d67336e38850d98574d8bec240c'

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
