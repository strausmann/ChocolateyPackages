Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$releases        = 'https://www.speedtest.net/de/apps/windows'
$ChecksumType    = 'sha256'

function global:au_GetLatest {
	$web = Invoke-WebRequest $releases
	$currentVersion = $web.AllElements | ?{$_.tagname -eq 'SPAN' -and $_.class -eq 'u-note'} | Select-Object -First 1 -Expand InnerText
	$version = $currentVersion.TrimStart("v")
	
	$req = Invoke-WebRequest -Uri $releases
	$currentVersion = $req.AllElements | ?{$_.tagname -eq 'SPAN' -and $_.class -eq 'u-note'} | Select-Object -First 1 -Expand InnerText
	$version = $currentVersion.TrimStart("v")
    
	$Url32 = "https://install.speedtest.net/app/windows/$($version)/speedtestbyookla_x86.msi"
	$Url64 = "https://install.speedtest.net/app/windows/$($version)/speedtestbyookla_x64.msi"
	
    return @{
        Url32           = $Url32
        Url64           = $Url64
		Version         = $version
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
