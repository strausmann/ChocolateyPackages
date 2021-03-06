﻿$ErrorActionPreference	= 'Stop';
$toolsDir				= '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'
$url					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.185-2/virtio-win-gt-x86.msi'
$url64					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.185-2/virtio-win-gt-x64.msi'
$checksum				= 'af97068ec651bd8d0d51debc4787babef4ef176ae0739b522d0e0a09fdb4cd90'
$checksum64				= '9fadc27c75638f7fc52366b5f3dcccf5564bbdafc4a04d1eabbfc052c7f4fc6d'

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