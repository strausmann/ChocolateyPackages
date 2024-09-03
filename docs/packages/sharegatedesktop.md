# <img src="https://cdn.jsdelivr.net/gh/strausmann/ChocolateyPackages/icons/sharegate-desktop.svg" width="32" height="32"/> [![ShareGate Desktop (Install)](https://img.shields.io/chocolatey/v/sharegate-desktop.svg?label=ShareGate+Desktop+(Install))](https://community.chocolatey.org/packages/sharegate-desktop) [![ShareGate Desktop (Install)](https://img.shields.io/chocolatey/dt/sharegate-desktop.svg)](https://community.chocolatey.org/packages/sharegate-desktop)

## Usage

To install ShareGate Desktop (Install), run the following command from the command line or from PowerShell:

```powershell
choco install sharegate-desktop
```

To upgrade ShareGate Desktop (Install), run the following command from the command line or from PowerShell:

```powershell
choco upgrade sharegate-desktop
```

To uninstall ShareGate Desktop (Install), run the following command from the command line or from PowerShell:

```powershell
choco uninstall sharegate-desktop
```

## Description

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



## Links

[Chocolatey Package Page](https://community.chocolatey.org/packages/sharegate-desktop)

[Software Site](https://sharegate.com/products/sharegate-desktop)

[Package Source](https://github.com/strausmann/ChocolateyPackages/tree/master/manual/sharegate-desktop)

