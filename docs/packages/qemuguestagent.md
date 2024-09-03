﻿# <img src="https://rawcdn.githack.com/strausmann/ChocolateyPackages/327464104957ec03a1c55ab68e1a72281b04e7b0/icons/qemu.png" width="32" height="32"/> [![Virtio Win Guest Tools (Install)](https://img.shields.io/chocolatey/v/qemu-guest-agent.svg?label=Virtio+Win+Guest+Tools+(Install))](https://community.chocolatey.org/packages/qemu-guest-agent) [![Virtio Win Guest Tools (Install)](https://img.shields.io/chocolatey/dt/qemu-guest-agent.svg)](https://community.chocolatey.org/packages/qemu-guest-agent)

## Usage

To install Virtio Win Guest Tools (Install), run the following command from the command line or from PowerShell:

```powershell
choco install qemu-guest-agent
```

To upgrade Virtio Win Guest Tools (Install), run the following command from the command line or from PowerShell:

```powershell
choco upgrade qemu-guest-agent
```

To uninstall Virtio Win Guest Tools (Install), run the following command from the command line or from PowerShell:

```powershell
choco uninstall qemu-guest-agent
```

## Description

Virtio-win-guest-tools

## Package Parameters

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

---

## [choco://qemu-guest-agent](choco://qemu-guest-agent)

To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support](https://chocolatey.org/packages/choco-protocol-support)

---

**Please Note**: This is an automatically updated package. If you find it is out of date by more than a day or two, please contact the maintainer(s) and let them know the package is no longer updating correctly.
	

## Links

[Chocolatey Package Page](https://community.chocolatey.org/packages/qemu-guest-agent)

[Software Site](https://github.com/virtio-win/kvm-guest-drivers-windows)

[Package Source](https://github.com/strausmann/ChocolateyPackages/tree/master/automatic/qemu-guest-agent)

