# <img src="https://rawcdn.githack.com/strausmann/ChocolateyPackages/327464104957ec03a1c55ab68e1a72281b04e7b0/icons/qemu.png" width="32" height="32"/> [![QEMU Guest Agent (Install)](https://img.shields.io/chocolatey/v/qemu-guest-agent.svg?label=QEMU+Guest+Agent+(Install))](https://community.chocolatey.org/packages/qemu-guest-agent) [![QEMU Guest Agent (Install)](https://img.shields.io/chocolatey/dt/qemu-guest-agent.svg)](https://community.chocolatey.org/packages/qemu-guest-agent)

## Usage

To install QEMU Guest Agent (Install), run the following command from the command line or from PowerShell:

```powershell
choco install qemu-guest-agent
```

To upgrade QEMU Guest Agent (Install), run the following command from the command line or from PowerShell:

```powershell
choco upgrade qemu-guest-agent
```

To uninstall QEMU Guest Agent (Install), run the following command from the command line or from PowerShell:

```powershell
choco uninstall qemu-guest-agent
```

## Description


The QEMU Guest Agent (QGA) is a Windows service that integrates virtual machines with QEMU/KVM-based hypervisors such as Proxmox VE, libvirt, oVirt/RHV, and OpenStack. It exposes an agent channel that allows the host to query information from the guest and perform certain coordinated actions inside the guest.

### Features
- Graceful guest shutdown/reboot initiated by the hypervisor
- Consistent snapshots via file system freeze/thaw
- Query of guest information (e.g., IP addresses, status) and execution of defined agent commands

### What this package does
- Installs the official QEMU Guest Agent for Windows (x86/x64) via MSI
- Creates and starts the "QEMU Guest Agent" Windows service (service name: qemu-ga)
- Suitable for unattended deployments with Chocolatey

### Separation from VirtIO drivers
This package contains only the QEMU Guest Agent. VirtIO drivers (e.g., network/block) are provided separately:
- Chocolatey package "qemu-virtio-driver": https://community.chocolatey.org/packages/qemu-virtio-driver

### Verification after installation
- Services console: "QEMU Guest Agent" should be set to Automatic and Running
- Command line: sc query "QEMU Guest Agent"
- In your hypervisor (e.g., Proxmox VE), enable the VM option for the QEMU guest agent

### Notes
- Project: https://gitlab.com/qemu-project/qemu
- Documentation (QGA): https://www.qemu.org/docs/master/interop/qemu-ga.html
- License: https://www.qemu.org/docs/master/about/license.html

### Disclaimer
This Chocolatey package is community-maintained and is not created, endorsed, or supported by the QEMU project.

---

[choco://qemu-virtio-driver](choco://qemu-virtio-driver)

To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support](https://chocolatey.org/packages/choco-protocol-support)

---

**Please Note**: This is an automatically updated package. If you find it is out of date by more than a day or two, please contact the maintainer(s) and let them know the package is no longer updating correctly.
    

## Links

[Chocolatey Package Page](https://community.chocolatey.org/packages/qemu-guest-agent)

[Software Site](https://gitlab.com/qemu-project/qemu)

[Package Source](https://github.com/strausmann/ChocolateyPackages/tree/master/automatic/qemu-guest-agent)

