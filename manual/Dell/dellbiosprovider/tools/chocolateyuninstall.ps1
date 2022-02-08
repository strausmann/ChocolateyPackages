$ErrorActionPreference = 'Stop'
$moduleName = $env:ChocolateyPackageName  # this may be different from the package name and different case

Get-InstalledModule -Name $moduleName | Uninstall-Module -AllVersions -Force -ErrorAction SilentlyContinue