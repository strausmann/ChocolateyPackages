$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://download.microsoft.com/download/a253d8fc-5e5e-4510-bdc2-885b98050574/SSMAforAccess_10.5.26034_x86.msi'
$checksum              = 'a118ae64189df2d62d0892c91dba77966d038c9ccb5cae58137135b80127d9dc'
$checksumType          = 'sha256'
$url64                 = 'https://download.microsoft.com/download/a253d8fc-5e5e-4510-bdc2-885b98050574/SSMAforAccess_10.5.26034.msi'
$checksum64            = '1cd733c844d69702a1789a8044367ce2e2351971abd96b04a739fa3f3d27411a'
$checksumType64        = 'sha256'

$packageArgs = @{
	packageName    = $env:ChocolateyPackageName
	softwareName   = 'Microsoft SQL Server Migration Assistant for Access*'
	installerType  = 'MSI'
	url            = $url
	url64bit       = $url64
	silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1 LICENSE_ACCEPTED=1"
	validExitCodes = @(0,1641,3010)
	checksum       = $checksum
	checksumType   = $checksumType
	Checksum64     = $checksum64
	ChecksumType64 = $checksumType64
}

Install-ChocolateyPackage @packageArgs
