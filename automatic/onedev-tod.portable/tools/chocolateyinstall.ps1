$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://code.onedev.io/~downloads/projects/1076/builds/243/artifacts/windows-amd64/tod.exe'
$checksum64 = 'df0784b6ed0d53fe1ae71c35ae0a6dc5b096a768643e43786e1634c0fdf036ae'

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
