$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'
$url					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.208-1/virtio-win-gt-x86.msi'
$url64					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.208-1/virtio-win-gt-x64.msi'
$checksum				= '0116900b2cf49d786793768f50888b836415e78b180d4868a0ee38c69d89ac01'
$checksum64				= 'fdcf77898ad8765358d621338a91544c93fdbc3a113b2b35bc09b704860171cb'

$cert = Get-ChildItem Cert:\CurrentUser\TrustedPublisher -Recurse | Where-Object { $_.Thumbprint -eq 'F01DAC89598C52D94FE8CA91187E1853947D115A' }
if (!$cert) {
    $toolsPath = Split-Path $MyInvocation.MyCommand.Definition
    Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$toolsPath\redhat.cer'"
}

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