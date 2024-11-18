$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'

$url					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.266-1/virtio-win-gt-x86.msi'
$checksum				= 'c40043157c1b403721554e1d9841215438404a6580d360a7b080b209e9f30cf0'
$checksumType           = 'sha256'
$url64					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.266-1/virtio-win-gt-x64.msi'
$checksum64				= '37b9ee622cff30ad6e58dea42fd15b3acfc05fbb4158cf58d3c792b98dd61272'
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
