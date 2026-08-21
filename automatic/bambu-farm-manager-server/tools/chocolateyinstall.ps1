$ErrorActionPreference = 'Stop'

# --- Source / package info ---
$url64          = 'https://public-cdn.bblmw.com/upgrade/farm-manager/Bambu_Farm_Manager_Server_win-v02.04.00.04-20260805164137.exe'
$Checksum64     = 'b5989618662297e4a171713f46ac3c079913bdd6f7445b245a2eee3f2c6054ce'
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
