$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'
$url					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.229-1/virtio-win-gt-x86.msi'
$url64					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.229-1/virtio-win-gt-x64.msi'
$checksum				= '7513fad3040ba76455fda4488bde8ab3f1c0f5b6f1fcda0c7a751b2d34d06af5'
$checksum64				= 'b26133dc7d193ea004767b227826bb04fea6cfa7a5f32c3022d875c2fdebe9af'

$packageArgs = @{
	packageName    = $env:ChocolateyPackageName
	softwareName   = 'Virtio-win-driver-installer*'
	installerType  = 'MSI'
	url            = $url
	checksum       = $checksum
	checksumType   = 'sha256'
	url64bit       = $url64
	checksum64     = $checksum64
	checksumType64 = 'sha256'
	silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
	validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs