Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

# Meta package: Version UND Dependency bleiben im Lockstep mit dem Unterpaket
# (Exakt-Pin [X], wie die git/nodejs/7zip-Metas). au_SearchReplace schreibt die
# Dependency-Version in der nuspec mit; AU bumpt die Meta-Version automatisch.
$release = Get-GitHubRelease fosrl newt

function global:au_GetLatest {
  return @{ Version = $release.tag_name }
}

function global:au_SearchReplace {
  @{
    "pangolin-newt.nuspec" = @{
      "(<dependency id=`"pangolin-newt.portable`" version=`")[^`"]*(`")" = "`${1}[$($Latest.Version)]`${2}"
    }
  }
}

Update-Package -ChecksumFor none
