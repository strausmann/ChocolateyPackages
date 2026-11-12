$ErrorActionPreference = 'Stop'

# --- Source / package info ---
$url64          = 'https://public-cdn.bblmw.com/upgrade/farm-manager/bambu-farm-manager-client-v3.2.0-660453f4-win32-x64.exe'
$Checksum64     = 'f691866c986a12267af7302e5b47c53331a63856bd2061777fe44b8f397120bd'
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
