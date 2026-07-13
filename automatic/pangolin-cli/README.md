# <img src="https://cdn.jsdelivr.net/gh/strausmann/ChocolateyPackages@502da828ff77bbc4ace5cb8f2683a47ce9858719/icons/pangolin.png" width="48" height="48"/> [pangolin-cli](https://community.chocolatey.org/packages/pangolin-cli)

## Pangolin CLI (Windows)

`pangolin` is the official Pangolin command-line client. On Windows it is used
for **SSH access to private Pangolin resources** — the CLI's built-in **VPN
tunnel is not supported on Windows**. The tunnel is provided by the separate
Pangolin Windows GUI client; the CLI runs the SSH workflow over that connection.

> For the VPN itself on Windows, install the Pangolin GUI client:
> https://pangolin.net/downloads/windows

### Requirements
- An active Pangolin client connection (the Windows GUI client must be connected
  to your org) for `pangolin ssh` to reach the private resource network.

### What this package installs
- `pangolin.exe` on PATH

### Log in
    pangolin login            # log in to Pangolin Cloud or your self-hosted instance

### SSH to a private resource
    pangolin ssh <dns-alias>          # e.g. pangolin ssh homeserver.ssh
    pangolin ssh <resource-id>        # resource identifier also works

Use `pangolin ssh --help` for options such as a non-default SSH port.

### Notes
- VPN/tunnel commands (e.g. `pangolin up`) are not supported on Windows; use the
  GUI client for connectivity.
- Works with both Pangolin Cloud and self-hosted Community/Enterprise instances.

**Please Note**: This is an automatically updated package. If you find it is out of date by more than a day or two, please contact the maintainer(s) and let them know the package is no longer updating correctly.
