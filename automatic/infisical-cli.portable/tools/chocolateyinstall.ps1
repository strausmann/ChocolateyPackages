$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://github.com/Infisical/cli/releases/download/v0.44.9/cli_0.44.9_windows_amd64.zip'
$checksum64 = 'a796bfaf03ba4c42d00e7c61b19ec4164992b86421fbee4d92b55847af79f3d2'

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
