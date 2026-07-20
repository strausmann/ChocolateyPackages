$ErrorActionPreference = 'Stop';

$url64      = 'https://github.com/fosrl/cli/releases/download/0.15.0/pangolin-cli_windows_installer.msi'
$checksum64 = '9b1c317fd16686a67cefaa1d68f6d134dedd7c4cfe0110ca0c281c9917fe37e6'

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
