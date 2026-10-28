Import-Module Chocolatey-AU

# The download page is behind a Cloudflare challenge, but the CyberBrick desktop app is an
# Electron app and updates itself from the standard electron-updater feed on Bambu's CDN.
# That feed is plain YAML, needs no browser and carries version, relative path and SHA-512.
$feedBase = 'https://public-cdn.bblmw.com/upgrade/cyber-brick/updates/Release_win32_x64'

function global:au_GetLatest {
  $yaml = (Invoke-WebRequest -Uri "$feedBase/latest.yml" -UseBasicParsing).Content
  if ($yaml -is [byte[]]) { $yaml = [Text.Encoding]::UTF8.GetString($yaml) }

  $version = ([regex]::Match($yaml, '(?m)^version:\s*(\S+)\s*$')).Groups[1].Value
  $path    = ([regex]::Match($yaml, '(?m)^path:\s*(\S+)\s*$')).Groups[1].Value
  $sha512  = ([regex]::Match($yaml, '(?m)^sha512:\s*(\S+)\s*$')).Groups[1].Value

  # Hard fail instead of pushing a broken package when the feed changes shape.
  if ($version -notmatch '^\d+(\.\d+){1,3}$') { throw "Unexpected version in latest.yml: '$version'." }
  if ($path -notmatch '^versions/[0-9A-Za-z.\-]+/cyber-brick-v[0-9A-Za-z.\-]+-win32-x64\.exe$') { throw "Unexpected path in latest.yml: '$path'." }
  if (-not $sha512) { throw 'latest.yml carries no sha512.' }

  # electron-updater publishes SHA-512 as Base64; Chocolatey expects hex.
  $checksum = ([Convert]::FromBase64String($sha512) | ForEach-Object { $_.ToString('x2') }) -join ''
  if ($checksum.Length -ne 128) { throw "sha512 in latest.yml has an unexpected length." }

  return @{
    Version      = $version
    Url32        = "$feedBase/$path"
    Checksum32   = $checksum
  }
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyinstall.ps1' = @{
      "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.Url32)'"
      "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksumType\s*=\s*)('.*')" = "`$1'sha512'"
    }
  }
}

if ($MyInvocation.InvocationName -ne '.') { Update-Package -ChecksumFor none }
