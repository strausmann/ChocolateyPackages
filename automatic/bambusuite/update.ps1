Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

# Bambu Suite ist Closed-Source (nicht auf GitHub) und die Download-Seite
# bambulab.com ist komplett hinter Cloudflare Turnstile (auch fuer echte Browser).
# Die einzige scriptbare (Cloudflare-freie) Quelle mit direkten CDN-Links inkl. des
# sonst nicht erratbaren Build-Timestamp-Ordners ist die Vendor-Wiki-Release-Seite.
$releases = 'https://wiki.bambulab.com/en/software/bambu-suite/release-notes'

function GetResultInformation([string]$Url32) {
  $fileName = Split-Path -Leaf $Url32
  $dest     = "$env:TEMP\$fileName"

  Get-WebFile $Url32 $dest | Out-Null

  $ChecksumType = 'sha256'
  $checksum32   = Get-FileHash $dest -Algorithm $ChecksumType | ForEach-Object Hash

  Remove-Item $dest -Force -ErrorAction SilentlyContinue

  @{
    Url32          = $Url32
    Checksum32     = $checksum32
    ChecksumType32 = $ChecksumType
  }
}

function global:au_GetLatest {
  $html = Invoke-WebRequest -Uri $releases -UseBasicParsing

  # Die Seite listet unter "Download Bambu Suite Historic Versions" direkte CDN-Links,
  # neueste zuerst. Erster Windows-.exe-Link = neueste Version.
  # Dateiname wechselt upstream zwischen 'Bambu_Suite_Public_Win_' und 'BambuSuite_Public_Win_'
  # -> nur auf '_Win_<version>.exe' matchen und die volle URL uebernehmen (nicht neu bauen).
  $Url32 = $html.Links |
    Where-Object { $_.href -match 'public-cdn\.bblmw\.com/general_pkg/prod/setup/.+_Win_\d{2}\.\d{2}\.\d{2}\.\d{2}\.exe$' } |
    Select-Object -First 1 -ExpandProperty href

  # Hard-Fail statt eine alte/leere URL zu pushen (schuetzt automatic/ bei Wiki-Layout-Aenderung).
  if (-not $Url32) { throw "au_GetLatest: Kein Windows-Installer-Link auf $releases gefunden (Wiki-Layout geaendert?)" }

  # Version aus dem Dateinamen: ..._01.02.02.00.exe -> 1.2.2.0 (jedes Segment ent-padden).
  if ($Url32 -notmatch '_Win_(\d{2})\.(\d{2})\.(\d{2})\.(\d{2})\.exe$') {
    throw "au_GetLatest: Versionsformat in '$Url32' unerwartet"
  }
  $version = '{0}.{1}.{2}.{3}' -f [int]$Matches[1], [int]$Matches[2], [int]$Matches[3], [int]$Matches[4]

  $ChecksumType = 'sha256'

  # ETag-basiert: die 300-MB-.exe nur laden, wenn sich der Installer geaendert hat.
  Update-OnETagChanged -execUrl $Url32 -OnETagChanged { GetResultInformation $Url32 } -OnUpdated { @{ Url32 = $Url32 } }

  @{
    Url32          = $Url32
    Version        = $version
    ChecksumType32 = $ChecksumType
    ReleaseNotes   = $releases
  }
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyinstall.ps1' = @{
      "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.Url32)'"
      "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(^[$]ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -key "releaseNotes" -value $Latest.ReleaseNotes
}

Update-Package -ChecksumFor 32
