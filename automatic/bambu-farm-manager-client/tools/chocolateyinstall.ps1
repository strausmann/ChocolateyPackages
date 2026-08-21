$ErrorActionPreference = 'Stop'

# --- Source / package info ---
$url64          = 'https://public-cdn.bblmw.com/upgrade/farm-manager/bambu-farm-manager-client-v2.4.4-1c4687aa-win32-x64.exe'
$Checksum64     = '0fac0f8ee00b34e2c699218e43dfc277e5a371064aa3f6714fda01057dca957b'
$ChecksumType64 = 'sha256'

# --- Target paths (per-user installation observed) ---
$installDir = Join-Path $env:LOCALAPPDATA 'Programs\CyberBrick'
$exePath    = Join-Path $installDir 'CyberBrick.exe'
$uninstPath = Join-Path $installDir 'Uninstall CyberBrick.exe'

# --- Use the package version from the nuspec for visibility/logging ---
$pkgVersion = $env:ChocolateyPackageVersion
Write-Host "Installing CyberBrick package version $pkgVersion ..."

# Close any running instance (useful for upgrades)
Get-Process CyberBrick -ErrorAction SilentlyContinue | Stop-Process -Force

# Perform silent install
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'CyberBrick*'
  fileType       = 'exe'
  url            = $url64
  checksum       = $checksum64
  checksumType   = $checksumType64
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

# Note for SYSTEM installs
if ($env:USERNAME -eq 'SYSTEM') {
  Write-Warning 'Running under SYSTEM: ARP entry skipped (it would be invisible to end users).'
}
