$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'
$url					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.221-1/virtio-win-gt-x86.msi'
$url64					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.221-1/virtio-win-gt-x64.msi'
$checksum				= '44a765d259214f3bf504dcaf168d6cc09e85e72fd03d3d99e48eafe6a4017193'
$checksum64				= '71888d2f258bfc2e8035f6be2335c82727a85c971b061ee64b7e618463680456'

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