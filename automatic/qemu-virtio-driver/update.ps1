Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

# Bugfix (Invalid version / empty version string in CI):
# The old logic scraped archive-virtio/ and sorted the directory links as plain
# strings (Sort-Object -Descending without a cast). This is fragile and produced
# an empty $link/$version in CI -> "ERROR: Invalid version:".
# New: latest-virtio/ is an upstream-provided 301 redirect folder that always
# points to the current versioned folder. The version is extracted directly from
# the redirect target (no more scraping/sorting needed).
$latestFolder = 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/'
$ChecksumType = 'sha256'

function global:au_GetLatest {

    # Location header points e.g. to .../archive-virtio/virtio-win-0.1.285-1/
    $resolved = Get-RedirectedUrl $latestFolder
    if (-not $resolved) { throw "Could not resolve redirect from $latestFolder." }

    # Upstream sometimes returns the redirect as http:// -> pin to https.
    $resolved = $resolved -replace '^http://', 'https://'

    if ($resolved -match 'virtio-win-(?<ver>\d+\.\d+\.\d+)-\d+') {
        $Version = $Matches['ver']
    } else {
        throw "Could not extract version from redirect target: $resolved"
    }

    # Pin to the resolved, versioned target (not to latest-virtio/ itself), so a
    # published package version keeps its MSI permanently.
    $base = $resolved.TrimEnd('/')
    $Url32 = "$base/virtio-win-gt-x86.msi"
    $Url64 = "$base/virtio-win-gt-x64.msi"

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