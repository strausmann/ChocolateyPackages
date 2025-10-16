$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'

$url					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-qemu-ga/qemu-ga-win-110.0.2-1.el10/qemu-ga-i386.msi'
$checksum				= 'fc37607d0063e6d4beca827d554dfa3f59417412098b3049e6bb44ac273f0820'
$checksumType           = 'sha256'
$url64					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-qemu-ga/qemu-ga-win-110.0.2-1.el10/qemu-ga-x86_64.msi'
$checksum64				= 'c50ea2e7c04730a1097ab6c112138645be4da26015518329daebe8d3630e0790'
$checksumType64         = 'sha256'

$packageArgs = @{
	packageName    = $env:ChocolateyPackageName
	installerType  = 'msi'
	softwareName   = 'QEMU guest agent*'
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
