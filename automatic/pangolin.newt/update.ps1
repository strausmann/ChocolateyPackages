Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$release = Get-GitHubRelease fosrl newt

function global:au_GetLatest {
  # GitHub-API kann (Rate-Limit auf geteilter CI-IP) leer zurueckkommen. Dann NICHT
  # mit leerer Version failen, sondern die aktuelle nuspec-Version behalten, damit
  # [PUSH]/choco pack weiterlaufen (Url/Checksum stehen fest in chocolateyinstall.ps1).
  if (-not $release -or [string]::IsNullOrWhiteSpace($release.tag_name)) {
    Write-Warning 'Get-GitHubRelease returned no data (GitHub API rate limit?) - keeping current nuspec version.'
    $nuspecPath = Join-Path $PSScriptRoot 'pangolin.newt.nuspec'
    $currentVersion = ([xml](Get-Content -LiteralPath $nuspecPath)).package.metadata.version
    return @{ Version = $currentVersion }
  }

  $version = $release.tag_name
  $asset = $release.assets | Where-Object { $_.name -match 'newt_windows_amd64\.exe' } | Select-Object -First 1
  $Url64 = $asset.browser_download_url

  return @{
    Version = $version
    Url64   = $Url64
  }
}

function global:au_BeforeUpdate {
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.Url64 -Algorithm 'sha256'
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "(?i)(^`$url64\s*=\s*)'.*'"      = "`${1}'$($Latest.Url64)'"
      "(?i)(^`$checksum64\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum64)'"
    }
  }
}

Update-Package -ChecksumFor none
