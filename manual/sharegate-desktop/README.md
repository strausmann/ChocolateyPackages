# <img src="https://cdn.jsdelivr.net/gh/strausmann/ChocolateyPackages/icons/sharegate-desktop.svg" width="48" height="48"/> [sharegate-desktop](https://community.chocolatey.org/packages/sharegate-desktop)

ShareGate-Desktop

### Package Specific
#### Installer Properties
The following install arguments can be passed:
* `LAUNCHSHAREGATEONEXIT`
* `SHAREGATETARGETEXECUTABLE`
* `CLICKONCEAPPNAME`
* `PRODUCTNAMESTOUNINSTALL`
* `NEWERFOUND`
* `OLDAPPFOUND`
* `PREVIOUSFOUND`
* `WIXNETFX4RELEASEINSTALLED`
* `APPLICATIONFOLDER`

To append install arguments to the current silent arguments passed to the installer, use `--install-arguments="''"` or `--install-arguments-sensitive="''"`. To completely override the silent arguments with your own, also pass `--override-arguments`.
Example: `choco install sharegate-desktop [other options] --install-arguments="'PROPERTY=value PROPERTY2=value2'"`
To have choco remember parameters on upgrade, be sure to set `choco feature enable -n=useRememberedArgumentsForUpgrades`.

