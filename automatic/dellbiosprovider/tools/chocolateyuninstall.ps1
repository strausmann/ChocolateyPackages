$ErrorActionPreference = 'Stop'
$moduleName   = 'DellBIOSProvider'

Get-InstalledModule -Name $moduleName |  Uninstall-Module -AllVersions -Force