Import-Module Chocolatey-AU

# Meta package: dot-sourced das update.ps1 des Unterpakets und nutzt dessen exaktes
# au_GetLatest (garantierter Lockstep, auch bei Fix-Revisions). Nur die nuspec-Dependency
# wird per au_SearchReplace auf [$Latest.Version] gepinnt; AU bumpt die Meta-<version>.
. $PSScriptRoot\..\infisical-cli.portable\update.ps1

function global:au_BeforeUpdate { }   # Meta braucht keinen Download / keine Checksum

function global:au_SearchReplace {
  @{
    "infisical.nuspec" = @{
      "(<dependency id=`"infisical-cli.portable`" version=`")[^`"]*(`")" = "`${1}[$($Latest.Version)]`${2}"
    }
  }
}

if ($MyInvocation.InvocationName -ne '.') { Update-Package -ChecksumFor none }
