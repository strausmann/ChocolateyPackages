Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$releases        = 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio'
$ChecksumType    = 'sha256'

function global:au_GetLatest {

    $web = Invoke-WebRequest $releases
    $links = $web.Links | Where-Object { $_.href -match "virtio-win-\d+\.\d+\.\d+-\d+/" } | Select-Object -ExpandProperty href
    
    $link = $links | Sort-Object -Descending | Select-Object -First 1
    $version = $link -replace '^virtio-win-(\d+\.\d+\.\d+)-\d+/.*$', '$1'
    
	$Url32 = "$($releases)/$($link)virtio-win-gt-x86.msi"
	$Url64 = "$($releases)/$($link)virtio-win-gt-x64.msi"
	
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