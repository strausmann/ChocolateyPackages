# <img src="https://cdn.jsdelivr.net/gh/strausmann/ChocolateyPackages/icons/qemu.png" width="48" height="48"/> [qemu-guest-agent](https://community.chocolatey.org/packages/qemu-guest-agent)

Virtio-win-guest-tools

**Please Note**: This is an automatically updated package. If you find it is
out of date by more than a day or two, please contact the maintainer(s) and
let them know the package is no longer updating correctly.

### Package Specific
#### Installer Properties
The following install arguments can be passed:
* `ALLUSERS`
* `1`
* `REGISTRY_PRODUCT_NAME`
* `REGISTRYSEARCH_IS_TERMSERVICE_EXIST`
* `REGISTRYSEARCH_IS_SPICEUSBREDIRECTOR_EXIST`
* `REGISTRYSEARCH_OLD_WGT_UNINSTALL_PATH`

To append install arguments to the current silent arguments passed to the installer, use `--install-arguments="''"` or `--install-arguments-sensitive="''"`. To completely override the silent arguments with your own, also pass `--override-arguments`.
Example: `choco install packageId [other options] --install-arguments="'PROPERTY=value PROPERTY2=value2'"`
To have choco remember parameters on upgrade, be sure to set `choco feature enable -n=useRememberedArgumentsForUpgrades`.

