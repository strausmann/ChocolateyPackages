$ErrorActionPreference = 'Stop';

$url64      = 'https://github.com/fosrl/cli/releases/download/0.19.0/pangolin-cli_windows_installer.msi'
$checksum64 = 'c05956682d1d3c99a21159dd1c6fcea24d53ef1866bfb77fb80328828ce67f13'

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
