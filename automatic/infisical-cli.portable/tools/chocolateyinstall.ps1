$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://github.com/Infisical/cli/releases/download/v0.43.139/cli_0.43.139_windows_amd64.zip'
$checksum64 = 'dbf30a405d064b999a02d3094fd18318dbb7f61fedc674849b634472176260e5'

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
