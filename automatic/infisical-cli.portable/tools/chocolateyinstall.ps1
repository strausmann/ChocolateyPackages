$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://github.com/Infisical/cli/releases/download/v0.45.4/cli_0.45.4_windows_amd64.zip'
$checksum64 = '33537924a25e3fc9c9ddb56099ff308b3f281a218ecd8a369cf881490c8633d4'

# Upstream liefert fuer Windows ein Portable-Binary im Zip (infisical.exe) - keinen nativen Installer.
# Install-ChocolateyZipPackage entpackt nach $toolsDir; Chocolatey legt automatisch einen 'infisical'-Shim
# auf den PATH. Kein Admin noetig, kein Uninstall-Script (choco entfernt Dateien + Shim bei uninstall).
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
