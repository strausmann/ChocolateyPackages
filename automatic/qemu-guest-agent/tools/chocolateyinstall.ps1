$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'

$url					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.285-1/virtio-win-gt-x86.msi'
$checksum				= 'e2ee7bc04e24ed3a3c90d573b75e5e809846db3c4de4e78655c1cc77ad2e2a3d'
$checksumType           = 'sha256'
$url64					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.285-1/virtio-win-gt-x64.msi'
$checksum64				= 'fafd93cb12b8a5df2668d3459d8b5589e7195a28424f9a40e16b50f462cf8fab'
$checksumType64         = 'sha256'

$packageArgs = @{
	packageName    = $env:ChocolateyPackageName
	installerType  = 'msi'
	softwareName   = 'Virtio-win-driver-installer*'
	silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	url64bit       = $url64
	checksum64     = $checksum64
	checksumType64 = $checksumType64
	validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
