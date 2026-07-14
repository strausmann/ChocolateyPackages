Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

# Meta package: keeps its own version in lockstep with the upstream release (and thus with
# the cli .install/.portable package) so `choco upgrade` propagates new versions. The
# dependency uses a fixed minimum floor and therefore never needs to be rewritten.
$release = Get-GitHubRelease fosrl cli

function global:au_GetLatest {
  return @{ Version = $release.tag_name }
}

function global:au_SearchReplace { @{} }

Update-Package -ChecksumFor none
