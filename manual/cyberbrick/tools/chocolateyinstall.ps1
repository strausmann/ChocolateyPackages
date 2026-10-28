$ErrorActionPreference = 'Stop'

# --- Source / package info ---
$url          = 'https://public-cdn.bblmw.com/upgrade/cyber-brick/updates/Release_win32_x64/versions/0.6.2/cyber-brick-v0.6.2-win32-x64.exe'
$checksum     = 'e90800cec4607f3bb6dcdbde48b7943309773be051eaf85e73367317d587e2ee'
$checksumType = 'sha256'

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
  url            = $url
  checksum       = $checksum
  checksumType   = $checksumType
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

# Note for SYSTEM installs
if ($env:USERNAME -eq 'SYSTEM') {
  Write-Warning 'Running under SYSTEM: ARP entry skipped (it would be invisible to end users).'
}
