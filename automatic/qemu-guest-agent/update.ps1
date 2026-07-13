Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

# Robustness improvement (not an active bugfix, this package resolves the current
# version 110.0.2 correctly even with the old scraping logic):
# latest-qemu-ga/ is an upstream-provided 301 redirect folder that always points
# to the current versioned folder under archive-qemu-ga/. This replaces scraping
# archive-qemu-ga/, where legacy `-el7ev` directories are mixed in alongside
# current ones and could confuse a plain version sort.
$latestFolder = 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-qemu-ga/'
$ChecksumType = 'sha256'

function global:au_GetLatest {

    # Location header points e.g. to .../archive-qemu-ga/qemu-ga-win-110.0.2-1.el10/
    $resolved = Get-RedirectedUrl $latestFolder
    if (-not $resolved) { throw "Could not resolve redirect from $latestFolder." }

    # Upstream sometimes returns the redirect as http:// -> pin to https.
    $resolved = $resolved -replace '^http://', 'https://'

    if ($resolved -match 'qemu-ga-win-(?<ver>\d+(?:\.\d+){2})-\d+') {
        $Version = $Matches['ver']
    } else {
        throw "Could not extract version from redirect target: $resolved"
    }

    # Pin to the resolved, versioned target (not to latest-qemu-ga/ itself), so a
    # published package version keeps its MSI permanently.
    $base = $resolved.TrimEnd('/')
    $Url32 = "$base/qemu-ga-i386.msi"
    $Url64 = "$base/qemu-ga-x86_64.msi"

    return @{
        Url32   = $Url32
        Url64   = $Url64
        Version = $Version
    }
}

function global:au_SearchReplace {
  @{
      'tools\chocolateyInstall.ps1' = @{
          "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.Url32)'"
          "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
          "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
          "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.Url64)'"
          "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
          "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
      }
  }
}

function global:au_AfterUpdate {
    Set-DescriptionFromReadme -SkipFirst 2
}

Update-Package -ChecksumFor all -NoCheckChocoVersion $true
