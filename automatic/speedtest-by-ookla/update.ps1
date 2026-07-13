Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$Url32        = 'https://install.speedtest.net/app/windows/latest/speedtestbyookla_x86.msi'
$Url64        = 'https://install.speedtest.net/app/windows/latest/speedtestbyookla_x64.msi'
$ChecksumType = 'sha256'

function global:au_GetLatest {
	# Ookla retired the versioned download path (`/app/windows/<version>/...msi`) -
	# requests to it now return 403 Forbidden. Only the static `/latest/` path still
	# works, but it no longer encodes the version in the URL or on the download page.
	# So the version has to be read from the downloaded MSI's ProductVersion property
	# instead of being scraped from https://www.speedtest.net/de/apps/windows.
	$fileName = Split-Path -Leaf $Url64
	$dest     = Join-Path $env:TEMP $fileName

	try {
		Get-WebFile $Url64 $dest | Out-Null
		$version = (Get-MsiInformation -Path $dest -Property ProductVersion).ProductVersion
	}
	finally {
		Remove-Item $dest -Force -ErrorAction SilentlyContinue
	}

	if ([string]::IsNullOrWhiteSpace($version)) {
		throw "Could not determine ProductVersion from $Url64"
	}

	return @{
		Url32   = $Url32
		Url64   = $Url64
		Version = $version
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
