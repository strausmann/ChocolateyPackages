$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
# Old Techsmith software versions can be found at https://www.techsmith.com/download/oldversions
$url64 = 'https://download.techsmith.com/snagit/releases/2016/snagit.msi'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
	softwareName   = 'Speedtest by Ookla*'
    installerType  = 'msi'
    url64bit       = $url64
    checksum64     = '82ED8FEC5EB12279030D7037DACEAEFDD0E9951E60FB342406B49BBDF6D22692'
    checksumType64 = 'SHA256'
    silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
    validExitCodes = @(0, 3010, 1641)
}

$arguments = Get-PackageParameters -Parameter $env:chocolateyPackageParameters
# use licensekey instead of licenseCode as this is consistent with Camtasia
if ($arguments.ContainsKey('licenseCode')) {
    if (-not ($arguments.ContainsKey('licensekey'))) {
        # create licensekey key with licenseCode value
        $arguments.licensekey = $arguments.licenseCode
    }
    $arguments.Remove('licenseCode')
}

foreach ($param in $arguments.Keys) {
    switch ($param) {
        "licensekey" {
            $licenseKey = $arguments["licensekey"]
            Write-Verbose "Parameter - License Key: $licenseKey"
            $packageArgs.silentArgs = "TSC_SOFTWARE_KEY=$licenseKey " + $packageArgs.silentArgs

            if ($arguments.ContainsKey("licensename")) {
                $licenseName = $arguments["licensename"]
                Write-Verbose "Parameter - License Name: $licenseName"
                $packageArgs.silentArgs = "TSC_SOFTWARE_USER=$licenseName " + $packageArgs.silentArgs
            }
        }

        "nodesktopshortcut" {
            Write-Verbose "Parameter - Desktop Shortcut: Disabled"
            $packageArgs.silentArgs = "TSC_DESKTOP_LINK=0 " + $packageArgs.silentArgs
        }
    }
}

Install-ChocolateyPackage @packageArgs