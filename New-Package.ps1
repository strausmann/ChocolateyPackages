param($Name, $Type)

<#
.SYNOPSIS
    Create a new package from the template

.DESCRIPTION
    This function creates a new package by using the directory _template which contains desired package basic settings.
#>
function New-Package{
    [CmdletBinding()]
    param(
        #Package name
        [string] $Name,

        #Type of the package
        [ValidateSet('Portable', 'Installer', 'EPortable', 'EInstaller')]
        [string] $Type,

        #Github repository in the form username/repository
        [string] $GithubRepository
    )

    if ($Name -eq $null) { throw "Name can't be empty" }
    if (Test-Path $Name) { throw "Package with that name already exists" }
    if (!(Test-Path _template)) { throw "Template for the packages not found" }
    Copy-Item _template automatic\$Name -Recurse

    $nuspec = Get-Content "automatic\$Name\template.nuspec"
    Remove-Item "automatic\$Name\template.nuspec"

    Write-Verbose 'Fixing nuspec'
    $nuspec = $nuspec -replace '<id>.+',               "<id>$Name</id>"
    $nuspec = $nuspec -replace '<iconUrl>.+',          "<iconUrl>https://cdn.jsdelivr.net/gh/$GithubRepository/icons/$Name.png</iconUrl>"
    $nuspec = $nuspec -replace '<packageSourceUrl>.+', "<packageSourceUrl>https://github.com/$GithubRepository/tree/master/$Name</packageSourceUrl>"
    $nuspec | Out-File -Encoding UTF8 "automatic\$Name\$Name.nuspec"

    switch ($Type)
    {
        'Installer' {
            Write-Verbose 'Using installer template'
            Move-Item "automatic\$Name\tools\chocolateyInstallExe.ps1" "automatic\$Name\tools\chocolateyInstall.ps1"
        }
        'Portable' {
            Write-Verbose 'Using portable template'
            Move-Item "automatic\$Name\tools\chocolateyInstallZip.ps1" "automatic\$Name\tools\chocolateyInstall.ps1"
        }
        'EInstaller' {
            Write-Verbose 'Using embedded installer template'
            Move-Item "automatic\$Name\tools\chocolateyInstallEmbeddedExe.ps1" "automatic\$Name\tools\chocolateyInstall.ps1"
        }
        'EPortable' {
            Write-Verbose 'Using embedded portable template'
            Move-Item "automatic\$Name\tools\chocolateyInstallEmbeddedZip.ps1" "automatic\$Name\tools\chocolateyInstall.ps1"
        }

        default { throw 'No template given' }
    }
    Remove-Item "automatic\$Name\tools\*.ps1" -Exclude chocolateyInstall.ps1, chocolateyUninstall.ps1

    Write-Verbose 'Fixing chocolateyInstall.ps1'
    $installer = Get-Content "automatic\$Name\tools\chocolateyInstall.ps1"
    $installer -replace "(^[$]packageName\s*=\s*)('.*')", "`$1'$($Name)'" | Set-Content "automatic\$Name\tools\chocolateyInstall.ps1"
}

New-Package $Name $Type -GithubRepository strausmann/ChocolateyPackages -Verbose
