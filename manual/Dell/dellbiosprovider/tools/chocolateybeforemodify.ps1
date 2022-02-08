$ErrorActionPreference = 'Stop'

$moduleName = $env:ChocolateyPackageName      # this could be different from package name

if (Get-Module -ListAvailable -Name $moduleName -ErrorAction SilentlyContinue){
	Get-InstalledModule -Name $moduleName | Uninstall-Module -AllVersions -Force -ErrorAction SilentlyContinue -Verbose
}