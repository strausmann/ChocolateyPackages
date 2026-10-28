Import-Module Chocolatey-AU

# Meta package: dot-sources the portable package's update.ps1 and reuses its exact
# au_GetLatest (guaranteed lockstep, including fix revisions). Only the nuspec dependency
# is pinned to [$Latest.Version]; AU bumps the meta <version>.
. $PSScriptRoot\..\onedev-tod.portable\update.ps1

function global:au_BeforeUpdate { }   # meta package needs no download / checksum

function global:au_SearchReplace {
  @{
    "onedev-tod.nuspec" = @{
      "(<dependency id=`"onedev-tod.portable`" version=`")[^`"]*(`")" = "`${1}[$($Latest.Version)]`${2}"
    }
  }
}

if ($MyInvocation.InvocationName -ne '.') { Update-Package -ChecksumFor none }
