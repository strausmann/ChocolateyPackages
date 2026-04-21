$ErrorActionPreference = 'Stop'

# --- Source / package info ---
$url64          = 'https://public-cdn.bblmw.com/upgrade/farm-manager/bambu-farm-manager-client-v2.3.0-d6350584-win32-x64.exe'
$Checksum64     = '7547d0faa1634d7f270102e9ed6b4428c0cee736134d0e607b066552d25f8304'
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
