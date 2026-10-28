$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://code.onedev.io/~downloads/projects/1076/builds/239/artifacts/windows-amd64/tod.exe'
$checksum64 = '484fcff4d2c89120ff5692c59a3f872dc1ba8ad384d91985d8b1650ad2a901a4'

# Upstream ships a single portable tod.exe (no installer). Chocolatey creates a 'tod' shim
# on the PATH automatically; no admin rights and no uninstall script are needed.
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'tod.exe'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Write-Host @"

tod is available on the PATH. Configure it once with:
  tod config set server-url https://onedev.example.com
  tod config set access-token <personal-access-token>

"@
