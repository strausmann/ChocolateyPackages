$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'
$url					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.204-1/virtio-win-gt-x86.msi'
$url64					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.204-1/virtio-win-gt-x64.msi'
$checksum				= 'f8a3184bd8827b72a2d67a465f144782d24e48b08d1bd1c577fcb2d1f1875c3b'
$checksum64				= '1898d53adb40930ee37b7c703093d9ff6e38a398db73ba84b94c47a7950d9402'

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