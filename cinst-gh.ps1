<# Installs package directly from Github repository
   To use with your own repo:
     - Set the path to your packages root in $Repo
     - Create short link to this raw github script via for example goo.gl
     - Commit nupkg files in the repository along with the package source code

   Usage:
     - Pass repository package name as a first argument
     - Pass any cinst option after that (some may not work ofc. such as `version`)

   Example:
     iwr https://goo.gl/SZ9c3m | iex; cinst-gh furmark --force
#>
function cinst-gh {
    $Repo = "https://github.com/strausmann/ChocolateyPackages/tree/master"

    $name = $args[0]
    $download_page = Invoke-WebRequest $Repo/$name -UseBasicParsing
    $url = $download_page.Links.href -like '*.nupkg'
    $p = $url -split '/' | Select-Object -last 1

    $raw = $Repo -replace 'github.com', 'rawgit.com' -replace 'tree/'
    Invoke-WebRequest "$raw/$(($p -split '\.')[0])/$p" -Out $p
    $a = $args | Select-Object -Skip 1
    $cmd = "cinst $p $a"
    Write-Host $cmd; Invoke-Expression $cmd
    Remove-Item $p
}
