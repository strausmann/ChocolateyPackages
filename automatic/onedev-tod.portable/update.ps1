Import-Module Chocolatey-AU

# Upstream publishes no GitHub release assets. The Windows binaries are artifacts of the
# "Release" job on code.onedev.io; the anonymous OneDev REST API lists those builds with
# their version and build number, which together form a stable, versioned download URL.
$apiBase = 'https://code.onedev.io/~api/builds'
$query   = '"Project" is "onedev/tod" and "Job" is "Release" and successful'

function global:au_GetLatest {
  $uri    = '{0}?query={1}&offset=0&count=1' -f $apiBase, [uri]::EscapeDataString($query)
  $build  = Invoke-RestMethod -Uri $uri -UseBasicParsing | Select-Object -First 1

  # Hard fail instead of pushing an empty or stale URL when the API changes shape.
  if (-not $build -or [string]::IsNullOrWhiteSpace($build.version) -or -not $build.number -or -not $build.projectId) {
    throw 'OneDev API returned no successful Release build for onedev/tod.'
  }

  $version = $build.version -replace '^v', ''
  $Url64   = 'https://code.onedev.io/~downloads/projects/{0}/builds/{1}/artifacts/windows-amd64/tod.exe' -f $build.projectId, $build.number

  return @{
    Version      = $version
    Url64        = $Url64
    ReleaseNotes = 'https://code.onedev.io/onedev/tod/~builds/{0}/fixed-issues' -f $build.number
  }
}

function global:au_BeforeUpdate {
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.Url64 -Algorithm 'sha256'
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.Url64)'"
      "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
    'onedev-tod.portable.nuspec' = @{
      '(<releaseNotes>)[^<]*(</releaseNotes>)' = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

if ($MyInvocation.InvocationName -ne '.') { Update-Package -ChecksumFor none }  # dot-source safe: only runs when invoked directly
