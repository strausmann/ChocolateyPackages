# Chocolatey Packages

[![Appveyor Build](https://ci.appveyor.com/api/projects/status/github/strausmann/ChocolateyPackages?svg=true)](https://ci.appveyor.com/project/strausmann/ChocolateyPackages)
[![Update status](https://img.shields.io/badge/Update-Status-blue.svg)](https://gist.github.com/strausmann/33cff89acf29181df2e5c7d2a3792d47)
[![chocolatey/virtualex](https://img.shields.io/badge/Chocolatey-strausmann-yellowgreen.svg)](https://community.chocolatey.org/profiles/strausmann)

If you have any issues with one of the packages hosted in this repository, please feel free to open an issue (preferred instead of using `Contact Maintainers` on chocolatey.org).

This repository contains [chocolatey automatic packages](https://docs.chocolatey.org/en-us/create/automatic-packages).
The repository is setup so that you can manage your packages entirely from the GitHub web interface (using AppVeyor to update and push packages) and/or using the local repository copy.

## Chocolatey Packages Template

This contains Chocolatey packages, both manually and automatically maintained.

### Folder Structure

* automatic - where automatic packaging and packages are kept. These are packages that are automatically maintained using [AU](https://community.chocolatey.org/packages/au).
* deprecated - where packages that are deprecated are kept.
* icons - Where you keep icon files for the packages. This is done to reduce issues when packages themselves move around.
* manual - where packages that are not automatic are kept.
* retired - where packages that are retired are kept.

For setting up your own automatic package repository, please see [Automatic Packaging](https://docs.chocolatey.org/en-us/create/automatic-packages)

### Requirements

* Chocolatey (choco.exe)
* [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au): `Install-Module au` or `choco install au`.

#### AU

* PowerShell v5+.
* The [AU module](https://community.chocolatey.org/packages/au).

For daily operations check out the AU packages [template README](https://github.com/majkinetor/au-packages-template/blob/master/README.md).

### Getting started

1. Fork this repository and rename it to `ChocolateyPackages` (on GitHub - go into Settings, Repository name and rename).
1. Clone the repository locally.
1. Head into the `setup` folder and perform the proper steps for your choice of setup (or both if you plan to use both methods).
1. Edit this README. Update the badges at the top.

### Recommendation on Auto Packaging

AU provides more in the process of being completely automated, sending emails when things go wrong, and providing a nice report at the end.

So for best visibility, enjoying the ease of using AppVeyor, and for a nice report of results. AU works directly with the xml/ps1 files to do replacement.

### Adapting your current source repository to this source repository template

You want to bring in all of your packages into the proper folders. We suggest using some sort of diffing tool to look at the differences between your current solution and this solution and then making adjustments to it. Pay special attention to the setup folder.

1. Bring over the following files to your package source repository:

* [automatic\README.md](automatic/README.md)
* `deprecated\README.md`
* `icons\README.md`
* `manual\README.md`
* `retired\README.md`
* `.appveyor.yml`

1. Inspect the following file and add the differences:

* `.gitignore`

## Automatic package update

### Single package

Run from within the directory of the package to update that package:

    cd <package_dir>
    ./update.ps1

If this script is missing, the package is not automatic.
Set `$au_Force = $true` prior to script call to update the package even if no new version is found.

### Multiple packages

To update all packages run `./update_all.ps1`. It accepts few options:

```powershell
./update_all.ps1 -Name a*                         # Update all packages which name start with letter 'a'
./update_all.ps1 -ForcedPackages 'cpu-z copyq'    # Update all packages and force cpu-z and copyq
./update_all.ps1 -ForcedPackages 'copyq:1.2.3'    # Update all packages but force copyq with explicit version
./update_all.ps1 -ForcedPackages 'libreoffice-streams\fresh:6.1.0]'    # Update all packages but force libreoffice-streams package to update stream `fresh` with explicit version `6.1.0`.
./update_all.ps1 -Root 'c:\packages'              # Update all packages in the c:\packages folder
```

The following global variables influence the execution of `update_all.ps1` script if set prior to the call:

```powershell
$au_NoPlugins = $true        #Do not execute plugins
$au_Push      = $false       #Do not push to chocolatey
```

You can also call AU method `Update-AUPackages` (alias `updateall`) on its own in the repository root. This will just run the updater for the each package without any other option from `update_all.ps1` script. For example to force update of all packages with a single command execute:

    updateall -Options ([ordered]@{ Force = $true })

## Testing all packages

You can force the update of all or subset of packages to see how they behave when complete update procedure is done:

```powershell
./test_all.ps1                            # Test force update on all packages
./test_all.ps1 'cdrtfe','freecad', 'p*'   # Test force update on only given packages
./test_all.ps1 'random 3'                 # Split packages in 3 groups and randomly select and test 1 of those each time
```

**Note**: If you run this locally your packages will get updated. Use `git reset --hard` after running this to revert the changes.

## Pushing To Community Repository Via Commit Message

You can force package update and push using git commit message. AppVeyor build is set up to pass arguments from the commit message to the `./update_all.ps1` script.

If commit message includes `[AU <forced_packages>]` message on the first line, the `forced_packages` string will be sent to the updater.

Examples:
- `[AU pkg1 pkg2]`
Force update ONLY packages `pkg1` and `pkg2`.
- `[AU pkg1:ver1 pkg2 non_existent]`
Force `pkg1` and use explicit version `ver1`, force `pkg2` and ignore `non_existent`.

To see how versions behave when package update is forced see the [force documentation](https://github.com/majkinetor/au/blob/master/README.md#force-update).

You can also push manual packages with command `[PUSH pkg1 ... pkgN]`. This works for any package anywhere in the file hierarchy and will not invoke AU updater at all.

If there are no changes in the repository use `--allow-empty` git parameter:

    git commit -m '[AU copyq less:2.0]' --allow-empty
    git push

## Start using AU with your own packages

To use this system with your own packages do the following steps:

* Fork this project. If needed, rename it to `au-packages`.
* Delete all existing packages.
* Edit the `README.md` header with your repository info.
* Set your environment variables. See [AU wiki](https://github.com/majkinetor/au/wiki#environment-variables) for details.

Add your own packages now, with this in mind:
* You can keep both manual and automatic packages together. To get only AU packages any time use `Get-AUPackages` function (alias `lsau` or `gau`)
* Keep all package additional files in the package directory (icons, screenshots etc.). This keeps everything related to one package in its own dir

## Notes

* https://github.com/majkinetor/au/wiki
