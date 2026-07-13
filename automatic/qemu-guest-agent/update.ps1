Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

# Robustheits-Verbesserung (kein akuter Bugfix, dieses Package findet die aktuelle
# Version 110.0.2 auch mit der alten Scraping-Logik):
# latest-qemu-ga/ ist ein von Upstream bereitgestellter 301-Redirect-Ordner, der
# immer auf den aktuellen versionierten Ordner unter archive-qemu-ga/ zeigt. Das
# ersetzt das Scraping von archive-qemu-ga/, wo neben aktuellen auch alte
# `-el7ev`-Legacy-Verzeichnisse liegen, die eine reine Versions-Sortierung
# verfaelschen koennen.
$latestFolder = 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-qemu-ga/'
$ChecksumType = 'sha256'

function Get-RedirectedUrl {
    param ([Parameter(Mandatory = $true)][string]$Url)

    $request = [System.Net.WebRequest]::Create($Url)
    $request.Method = 'HEAD'
    $request.AllowAutoRedirect = $false
    $response = $request.GetResponse()
    try {
        return $response.GetResponseHeader('Location')
    } finally {
        $response.Close()
    }
}

function global:au_GetLatest {

    # Location-Header zeigt z.B. auf .../archive-qemu-ga/qemu-ga-win-110.0.2-1.el10/
    $resolved = Get-RedirectedUrl $latestFolder
    if (-not $resolved) { throw "Konnte Redirect von $latestFolder nicht aufloesen." }

    # Upstream liefert den Redirect teils als http:// -> auf https pinnen.
    $resolved = $resolved -replace '^http://', 'https://'

    if ($resolved -notmatch 'qemu-ga-win-(?<ver>\d+(?:\.\d+){2})-\d+') {
        throw "Konnte Version aus Redirect-Ziel nicht extrahieren: $resolved"
    }
    $Version = $Matches['ver']
    if ([string]::IsNullOrWhiteSpace($Version)) {
        throw "Invalid version: Redirect-Ziel enthielt keine gueltige Versionsnummer ($resolved)."
    }

    # Auf das aufgeloeste, versionierte Ziel pinnen (nicht auf latest-qemu-ga/ selbst),
    # damit eine veroeffentlichte Package-Version dauerhaft ihr MSI behaelt.
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
