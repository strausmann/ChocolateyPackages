$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
# software versions can be found at https://developer.microsoft.com/en-us/microsoft-edge/webview2/#download-section
$url64 = 'https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/efd96b25-c48c-49a0-ae42-92c2a383baea/MicrosoftEdgeWebview2Setup.exe'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
	softwareName   = 'Microsoft Edge Update*'
    installerType  = 'exe'
    url64bit       = $url64
    checksum64     = 'ba0c65d8803af47ee63b69d695c1ca9160b074171b51edc90b07145e43aec44f'
    checksumType64 = 'SHA256'
    silentArgs     = "/silent /install"
    validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs