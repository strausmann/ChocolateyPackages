Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$releases        = 'https://wiki.bambulab.com/en/software/bambu-connect'
$ChecksumType    = 'sha256'

function global:au_GetLatest {
    # Webseite abrufen
    $web = Invoke-WebRequest -Uri $releases

    # Alle relevanten Links filtern
    $downloadLinks = $web.Links | Where-Object {
        $_.outerHTML -match "bambu-connect.*\.exe"
    }

    if (-not $downloadLinks) {
        throw "Keine passenden Download-Links gefunden."
    }

    # Den ersten gefundenen Link extrahieren
    $downloadLink = $downloadLinks[0].href

    # Versionsnummer aus dem Link extrahieren (alles nach 'v' und vor dem nächsten '_')
    if ($downloadLink -match "bambu-connect.*-v([\d\.]+)_") {
        $version = $Matches[1]
    } else {
        throw "Versionsnummer konnte nicht aus dem Download-Link extrahiert werden."
    }

    return @{
        Url64   = $downloadLink
        Version = $version
    }
}


function GetResultInformation([string]$Url64) {
  $fileName = Split-Path -Leaf $Url64
  $dest = "$env:TEMP\$fileName"

  Get-WebFile $Url64 $dest | Out-Null

  $version         = (Get-Command $dest).FileVersionInfo.ProductVersion
  $ChecksumType    = 'sha256'
  $checksum32      = Get-FileHash $dest -Algorithm $checksumType | ForEach-Object Hash

  Remove-Item $dest -Force -ErrorAction SilentlyContinue

  @{
    Url64             = $Url64
    Version           = $version
	Checksum64        = $checksum64
    ChecksumType64    = $ChecksumType
  }
}

function global:au_GetLatest {
  $Url32 = $release.assets | ? {$_.name -match 'Bambu_Studio_win_public' } | ? { $_.name.endswith('.exe') } | select -First 1 -ExpandProperty browser_download_url

  $version = $release.tag_name.Trim('v')
  $ChecksumType = 'sha256'

  $tag = $release.tag_name
  $ReleaseNotes = "https://github.com/bambulab/BambuStudio/releases/tag/$($tag)"

  Update-OnETagChanged -execUrl $Url32 -OnETagChanged { GetResultInformation $Url32 } -OnUpdated { @{ Url32 = $Url32 } }

  @{
    Url32             = $Url32
    Version           = $version
    ChecksumType32    = $ChecksumType
    ReleaseNotes      = $ReleaseNotes
  }
}

function global:au_SearchReplace {
  @{
      'tools\chocolateyInstall.ps1' = @{
          "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.Url32)'"
          "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
          "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
      }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -key "releaseNotes" -value $Latest.ReleaseNotes
}

Update-Package -ChecksumFor 32
