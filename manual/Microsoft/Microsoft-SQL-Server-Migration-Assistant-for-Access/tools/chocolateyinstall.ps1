$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_8.23.0_x86.msi'
$checksum              = '0df47a580f4c3a06e1224aab524cde3cf92455f43a42a961ae1c2634fead3387'
$urlx64                = 'https://download.microsoft.com/download/D/B/D/DBDECC99-4DCA-4674-983A-CC1ABABA2B37/SSMAforAccess_8.23.0.msi'
$checksumx64           = '57139cf24ddc7326c391e6ebd78d128c8a58ab27ad1159ebcfd8af4dc0254758'

$packageArgs = @{
	packageName    = $env:ChocolateyPackageName
	softwareName   = 'Microsoft SQL Server Migration Assistant for Access*'
	installerType  = 'MSI'
	url            = $url
	url64bit       = $urlx64
	silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1 LICENSE_ACCEPTED=1"
	validExitCodes = @(0,1641,3010)
	checksum       = $checksum
	checksumType   = 'sha256'
	Checksum64     = $checksumx64
	ChecksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs