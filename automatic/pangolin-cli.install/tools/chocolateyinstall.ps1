$ErrorActionPreference = 'Stop';

$url64      = 'https://github.com/fosrl/cli/releases/download/0.20.0/pangolin-cli_windows_installer.msi'
$checksum64 = '1c227ee2f7050e7be9ee04415c8b4a831e09c834131751511f307024409b302a'

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
