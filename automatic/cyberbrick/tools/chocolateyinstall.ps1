$ErrorActionPreference = 'Stop'

# --- Source / package info ---
$url          = 'https://public-cdn.bblmw.com/upgrade/cyber-brick/updates/Release_win32_x64/versions/0.6.2/cyber-brick-v0.6.2-win32-x64.exe'
$checksum     = '810ff9b9b19707ecaed487344e7adc98a813f7f843c887ee6951e72a10f6bd9435223ff416bbadb673a7395264038a9db72c4053577a742b30ac44706be609eb'
$checksumType = 'sha512'

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
