Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$releases       = 'https://wiki.bambulab.com/en/software/bambu-farm-manager'
$ChecksumType64 = 'sha256'

function Normalize-Version([string]$v) {
  if (-not $v) { return $null }
  $v = $v -replace '[^\d\.]', ''
  $parts = $v.Split('.') | ForEach-Object {
    if ($_ -match '^\d+$') { [int]$_ } else { $_ }
  }
  ($parts -join '.')
}

function Find-Link([object]$html, [string]$role) {
  $pred = { param($l) ($l.outerHTML -match "(?i)$role") -and ($l.href -match '\.exe(\?|$)') }
  $link = $html.Links | Where-Object { & $pred $_ } | Select-Object -First 1
  if (-not $link) {
    $link = $html.Links | Where-Object { $_.href -match '\.exe(\?|$)' } | Select-Object -First 1
  }
  return $link
}

function Try-ExtractVersion([string]$text) {
  $m = [regex]::Match($text, '(\d{1,2}\.\d{1,2}\.\d{1,2}\.\d{1,2})')
  if (-not $m.Success) { $m = [regex]::Match($text, '(\d{1,2}\.\d{1,2}\.\d{1,2})') }
  if (-not $m.Success) { $m = [regex]::Match($text, '(\d{8})') }
  if ($m.Success) { return $m.Groups[1].Value } else { return $null }
}

function global:au_GetLatest {
  $html = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $link = Find-Link -html $html -role 'server'
  if (-not $link) { throw "Could not find a Windows .exe link for SERVER on $releases" }

  $near = ($link.innerText + ' ' + $link.outerHTML)
  $ver  = Try-ExtractVersion $near
  if (-not $ver -and $html.ParsedHtml) {
    $ver = Try-ExtractVersion $html.ParsedHtml.body.innerText
  }
  if (-not $ver) {
    $file = [System.IO.Path]::GetFileName($link.href)
    $ver = Try-ExtractVersion $file
  }
  if (-not $ver) { throw "Could not parse SERVER version from page or link context." }

  $versionOut = Normalize-Version $ver
  if (-not $versionOut) { throw "Version normalization failed for '$ver'." }

  return @{
    Url64          = $link.href
    Version        = $versionOut
    ChecksumType64 = $ChecksumType64
    ReleaseNotes   = $releases
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
}

Update-Package -ChecksumFor 64