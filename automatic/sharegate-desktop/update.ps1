Import-Module AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$releases = "https://documentation.sharegate.com/hc/en-us/sections/360005954591-Patch-Notes"

function global:au_GetLatest {

	$response = Invoke-WebRequest -Uri $releases
	$versionPattern = 'Patch (\d+\.\d+\.\d+)'
	$versionMatches = [regex]::Matches($response.Content, $versionPattern)
	$version = $versionMatches[0].Groups[1].Value
	$versionWithDashes = $versionMatches[0].Groups[1].Value -replace '\.', '-'
	$versionLinkPattern = 'href="([^"]+Patch-' + [regex]::Escape($versionWithDashes) + ')"'
	$versionLinkMatch = [regex]::Match($response.Content, $versionLinkPattern)
	$versionLink = "https://documentation.sharegate.com" + $versionLinkMatch.Groups[1].Value
	$versionResponse = Invoke-WebRequest -Uri $versionLink
	$downloadLinkPattern = 'href="([^"]+\.msi)"'
	$downloadLinkMatch = [regex]::Match($versionResponse.Content, $downloadLinkPattern)
	$downloadLink = $downloadLinkMatch.Groups[1].Value

    return @{
        Url32           = $downloadLink
		Version         = $version
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

Update-Package -ChecksumFor 32 -NoCheckChocoVersion $true