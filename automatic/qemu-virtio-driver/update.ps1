Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

# Bugfix (Invalid version / leerer Version-String im CI):
# Die alte Logik scrapte archive-virtio/ und sortierte die Verzeichnis-Links als
# Strings (Sort-Object -Descending ohne Cast). Das ist fragil und lieferte im CI
# ein leeres $link/$version -> "ERROR: Invalid version:".
# Neu: latest-virtio/ ist ein von Upstream bereitgestellter 301-Redirect-Ordner,
# der immer auf den aktuellen versionierten Ordner zeigt. Die Version wird direkt
# aus dem Redirect-Ziel extrahiert (kein Scraping/Sortieren mehr noetig).
$latestFolder = 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/'
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

    # Location-Header zeigt z.B. auf .../archive-virtio/virtio-win-0.1.285-1/
    $resolved = Get-RedirectedUrl $latestFolder
    if (-not $resolved) { throw "Konnte Redirect von $latestFolder nicht aufloesen." }

    # Upstream liefert den Redirect teils als http:// -> auf https pinnen.
    $resolved = $resolved -replace '^http://', 'https://'

    if ($resolved -notmatch 'virtio-win-(?<ver>\d+\.\d+\.\d+)-\d+') {
        throw "Konnte Version aus Redirect-Ziel nicht extrahieren: $resolved"
    }
    $Version = $Matches['ver']
    if ([string]::IsNullOrWhiteSpace($Version)) {
        throw "Invalid version: Redirect-Ziel enthielt keine gueltige Versionsnummer ($resolved)."
    }

    # Auf das aufgeloeste, versionierte Ziel pinnen (nicht auf latest-virtio/ selbst),
    # damit eine veroeffentlichte Package-Version dauerhaft ihr MSI behaelt.
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