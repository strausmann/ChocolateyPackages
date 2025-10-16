Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "../../scripts/au_extensions.psm1"

$releases     = 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-qemu-ga/'
$ChecksumType = 'sha256'

function global:au_GetLatest {

    $web = Invoke-WebRequest $releases

    # passt auch auf ...-1.el10/ etc.
    $rx = 'qemu-ga-win-(?<ver>\d+(?:\.\d+){2})-(?<rel>\d+)(?:\.[^/]+)?/'

    $candidates = foreach ($a in $web.Links) {
        if ($a.href -match $rx) {
            [pscustomobject]@{
                Href = $a.href
                Ver  = [version]$Matches['ver']   # z.B. 110.0.2
                Rel  = [int]$Matches['rel']       # z.B. 1
            }
        }
    }
	
    $latest = $candidates | Sort-Object Ver, Rel -Descending | Select-Object -First 1
    if (-not $latest) { throw "Keine passenden qemu-ga-win-Verzeichnisse gefunden." }

    $href = if ($latest.Href -match '/$') { $latest.Href } else { "$($latest.Href)/" }
    $folderUri = if ([Uri]::IsWellFormedUriString($href, [UriKind]::Absolute)) {
        [Uri]$href
    } else {
        [Uri]::new([Uri]$releases, $href)
    }
    $base = $folderUri.AbsoluteUri.TrimEnd('/')
    $Url32 = "$base/qemu-ga-i386.msi"
    $Url64 = "$base/qemu-ga-x86_64.msi"
    $Version = $latest.Ver.ToString()

    return @{
        Url32   = $Url32
        Url64   = $Url64
        Version = $Version
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
