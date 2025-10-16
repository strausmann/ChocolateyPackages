# <img src="https://rawcdn.githack.com/strausmann/ChocolateyPackages/42ce175aa29adbed0f958bb9d1f748118c5d56ab/icons/virtio.png" width="32" height="32"/> [![Virtio Win Driver (Install)](https://img.shields.io/chocolatey/v/qemu-virtio-driver.svg?label=Virtio+Win+Driver+(Install))](https://community.chocolatey.org/packages/qemu-virtio-driver) [![Virtio Win Driver (Install)](https://img.shields.io/chocolatey/dt/qemu-virtio-driver.svg)](https://community.chocolatey.org/packages/qemu-virtio-driver)

## Usage

To install Virtio Win Driver (Install), run the following command from the command line or from PowerShell:

```powershell
choco install qemu-virtio-driver
```

To upgrade Virtio Win Driver (Install), run the following command from the command line or from PowerShell:

```powershell
choco upgrade qemu-virtio-driver
```

To uninstall Virtio Win Driver (Install), run the following command from the command line or from PowerShell:

```powershell
choco uninstall qemu-virtio-driver
```

## Description

VirtIO drivers for Windows guests on QEMU/KVM

This package installs the official virtio-win drivers from Red Hat for Windows guest systems in QEMU/KVM environments (e.g., Proxmox VE, libvirt, oVirt/RHV, OpenStack). The paravirtualized drivers improve performance and integration compared to fully emulated devices.

### Included components (depending on guest and selected hardware)
- NetKVM (VirtIO network)
- viostor / vioscsi (VirtIO block / SCSI)
- Balloon (memory ballooning)
- viorng (VirtIO RNG)
- vioinput / vioserial
- optionally qxldod / SPICE display drivers

### What this package does
- Installs VirtIO drivers via the official MSIs (virtio-win-gt-x86/x64.msi)
- Deploys signed (partly WHQL-certified) drivers for the relevant device classes
- Suitable for unattended/automated deployments with Chocolatey

### Not included
- QEMU Guest Agent (install separately):
  Chocolatey package: https://community.chocolatey.org/packages/qemu-guest-agent

### Compatibility and requirements
- Windows 10/11 and Windows Server (per upstream support)
- Administrator privileges required; a reboot may be required
- Hypervisor: QEMU/KVM (e.g., Proxmox VE, libvirt)

### Verification after installation
- Device Manager: VirtIO devices should bind to Red Hat drivers (NetKVM, viostor/vioscsi, etc.)
- Optional: verify driver versions under Properties → Driver

### Disclaimer
This Chocolatey package is community-maintained and is not created, endorsed, or supported by the Red Hat.

---

[choco://qemu-virtio-driver](choco://qemu-virtio-driver)

To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support](https://chocolatey.org/packages/choco-protocol-support)

---

**Please Note**: This is an automatically updated package. If you find it is out of date by more than a day or two, please contact the maintainer(s) and let them know the package is no longer updating correctly.


## Links

[Chocolatey Package Page](https://community.chocolatey.org/packages/qemu-virtio-driver)

[Software Site](https://github.com/virtio-win/kvm-guest-drivers-windows)

[Package Source](https://github.com/strausmann/ChocolateyPackages/tree/master/automatic/qemu-virtio-driver)

