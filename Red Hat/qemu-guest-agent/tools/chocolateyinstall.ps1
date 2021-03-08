$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.173-9/virtio-win-gt-x64.msi'
$checksum              = 'c5a3a52a78a2e63f5f2950ffff6cf777b5b01b1fe78d449728ea86ec6accca8b'

#Items that could be replaced based on what you call chocopkgup.exe with
#{{PackageName}} - Package Name (should be same as nuspec file and folder) |/p
#{{PackageVersion}} - The updated version | /v
#{{DownloadUrl}} - The url for the native file | /u
#{{PackageFilePath}} - Downloaded file if including it in package | /pp
#{{PackageGuid}} - This will be used later | /pg
#{{DownloadUrlx64}} - The 64-bit url for the native file | /u64
#{{Checksum}} - The checksum for the url | /c
#{{Checksumx64}} - The checksum for the 64-bit url | /c64
#{{ChecksumType}} - The checksum type for the url | /ct
#{{ChecksumTypex64}} - The checksum type for the 64-bit url | /ct64

#Based on Msi

$packageArgs = @{
	packageName    = $env:ChocolateyPackageName
	softwareName  = 'QEMU guest agent*'
	installerType  = 'MSI'
	url            = $url
	silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
	validExitCodes = @(0)
	checksum       = $checksum
	checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs