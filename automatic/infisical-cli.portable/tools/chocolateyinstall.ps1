$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://github.com/Infisical/cli/releases/download/v0.43.130/cli_0.43.130_windows_amd64.zip'
$checksum64 = '62304f5e3b0225ddecffe761505348292c4be7e909e004fb21356721794cfac9'

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
