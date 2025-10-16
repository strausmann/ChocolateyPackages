Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$releases     = 'https://wiki.bambulab.com/en/software/bambu-connect'
$ChecksumType = 'sha256'
$BaseTitle    = 'Bambu Connect (Install)'

function global:au_GetLatest {

    $web = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $content = $web.Content

    # Windows x64 EXE Links extrahieren
    $rxHref = 'href\s*=\s*"(?<url>[^"]*bambu-connect[^"]*win32-x64[^"]*\.exe)"'
    $matches = [regex]::Matches(
        $content,
        $rxHref,
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor
        [System.Text.RegularExpressions.RegexOptions]::Multiline
    )

    if ($matches.Count -eq 0) {
        throw "No Windows x64 download link found on $releases"
    }

    # 1) Version aus '.../versions/<ver>/' (bevorzugt)
    $rxFromFolder = '/versions/(?<ver>[^/]+)/'

    # 2) Fallback: aus Dateinamen (SemVer + optionales Prerelease), aber
    #    STOPPE VOR '-win32-x64' ODER '.exe'  -> via Lookahead:
    #    Beispiele, die matchen:
    #      ...bambu-connect-v2.0.0-win32-x64.exe
    #      ...bambu-connect-v2.0.0-beta.7-win32-x64.exe
    #      ...bambu-connect-2.0.0.exe
    $rxFromName   = 'bambu-connect-?v(?<ver>\d+\.\d+\.\d+(?:-[0-9A-Za-z]+(?:\.[0-9A-Za-z]+)*)?)(?=-win32-x64|\.exe|")'

    $candidates = foreach ($m in $matches) {
        $u = $m.Groups['url'].Value

        # absolute URL (PS5-kompatibel)
        $abs = if ([Uri]::IsWellFormedUriString($u, [UriKind]::Absolute)) {
            [Uri]$u
        } else {
            New-Object System.Uri ($releases, $u)
        }
        $url = $abs.AbsoluteUri

        $verStr = $null
        if ($url -match $rxFromFolder) {
            $verStr = $Matches['ver']
        } elseif ($url -match $rxFromName) {
            $verStr = $Matches['ver']
        } else {
            continue
        }

        $numPart   = ($verStr -split '-', 2)[0]  # "2.0.0"
        $isPre     = if ($verStr -match '-') { 1 } else { 0 }

        [pscustomobject]@{
            Url          = $url
            VersionStr   = $verStr
            VersionNum   = [version]$numPart
            IsPrerelease = $isPre
        }
    }

    if (-not $candidates) {
        throw "Found links but could not parse versions."
    }

    # Stable-first
    $stable = $candidates | Where-Object { $_.IsPrerelease -eq 0 }
    if ($stable) {
        $latest = $stable | Sort-Object VersionNum -Descending | Select-Object -First 1
        $isBetaOnly = $false
    } else {
        $latest = $candidates | Sort-Object VersionNum, IsPrerelease -Descending | Select-Object -First 1
        $isBetaOnly = $true
    }

    # Beta-only: Version auf numerischen Teil schrumpfen; Titel mit " - Beta"
    $versionOut = if ($isBetaOnly) { $latest.VersionNum.ToString() } else { $latest.VersionStr }
    $titleOut   = if ($isBetaOnly) { "$BaseTitle - Beta" } else { $BaseTitle }

    return @{
        Url64          = $latest.Url
        Version        = $versionOut
        ChecksumType64 = $ChecksumType
        ReleaseNotes   = $releases
        IsBetaOnly     = $isBetaOnly
        TitleOut       = $titleOut
    }
}

function global:au_SearchReplace {
  @{
      'tools\chocolateyInstall.ps1' = @{

          "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.Url64)'"
          "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
          "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
      }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -key "releaseNotes" -value $Latest.ReleaseNotes
  Update-Metadata -key "title"        -value $Latest.TitleOut
}

Update-Package -ChecksumFor 64