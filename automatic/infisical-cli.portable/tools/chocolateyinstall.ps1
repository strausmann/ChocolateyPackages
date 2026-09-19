$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://github.com/Infisical/cli/releases/download/v0.43.133/cli_0.43.133_windows_amd64.zip'
$checksum64 = '73877e55b9bc38823ce36034a42fb9094eed339d8eb0d3716b83204fc84c90ca'

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
