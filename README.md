# nixos-config

> **Ex dissatisfactione, evolutio.**  
> _(Out of dissatisfaction, evolution.)_

My personal, flake-based NixOS configurations. Born out of systemic dissatisfaction with imperative operating systems, this repository represents a continuous evolution toward a predictable, reproducible, and highly optimized desktop environment.

Tailored for high-performance hardware while maintaining a resilient, hardware-agnostic portable target.

## System Architecture

This repository uses a modular multi-host architecture. Hosts define machine-specific hardware and policy choices, while reusable modules provide the common system baseline and selectable implementations.

```text
├── flake.nix
├── hosts/
│   ├── asus/
│   │   └── rog/
│   │       ├── strix/scar/15/g533qr.nix
│   │       └── zephyrus/m16/gu604vi.nix
│   ├── lenovo/
│   │   └── yoga/7/14irl8.nix
│   └── portable.nix
└── modules/
    ├── bootloader/
    │   ├── default.nix
    │   ├── grub.nix
    │   ├── limine.nix
    │   └── refind.nix
    ├── display-manager/
    │   ├── lemurs.nix
    │   ├── lightdm.nix
    │   ├── ly.nix
    │   └── sddm.nix
    ├── filesystem/
    │   ├── btrfs.nix
    │   └── ext4.nix
    ├── hardware/
    │   ├── amd.nix
    │   ├── intel.nix
    │   └── nvidia.nix
    ├── networking/
    │   ├── default.nix
    │   ├── dnscrypt-proxy.nix
    │   ├── dnsproxy.nix
    │   └── systemd-resolved.nix
    ├── core.nix
    ├── default.nix
    ├── imaging.nix
    ├── locale.nix
    └── userland.nix
```

### Configurations

- `vize-portable` — hardware-agnostic portable environment using Ext4
- `vize-strix-scar-15-g533qr` — ASUS ROG Strix SCAR 15 with AMD/NVIDIA hybrid graphics
- `vize-zephyrus-m16-gu604vi` — ASUS ROG Zephyrus M16 with Intel/NVIDIA hybrid graphics
- `vize-yoga-7-14irl8` — Lenovo Yoga 7 with Intel graphics

## Feature Highlights

- **Bootloaders:** Selectable `GRUB`, `Limine`, `rEFInd`, or `systemd-boot` backend with shared boot policy and backend-specific configuration.
- **Display Manager:** Deploys `ly`, a lightweight TUI display manager configured with an animated **colormix** background. Alternative Lemurs, LightDM, and SDDM configurations are also maintained.
- **Domain Name System:** Selectable `dnscrypt-proxy`, `dnsproxy`, `systemd-resolved`, or unmanaged DNS. The default `dnsproxy` configuration uses encrypted **DNS-over-QUIC** with AdGuard and HTTPS fallback.
- **Filesystems:** Supports Ext4 and Btrfs with swapfiles or swap partitions and Zswap.
- **Hardware:** Modular AMD, Intel, and NVIDIA support with hybrid graphics, PRIME offload, NVIDIA power management, and hardware-dependent GPU acceleration.
- **System Maintenance:** Automated garbage collection on the first and third **Monday** of each month and Nix store optimization on the first and third **Friday**.
- **Window Manager:** Uses `Hyprland` as the primary Wayland compositor.
- **Containers:** Provides rootless container tooling through `Podman`.

## Userland

The shared desktop and command-line environment is defined in `modules/userland.nix`.

- **Applications:** `bitwarden-desktop`, `davinci-resolve`, `firefox`, `gimp`, `keepassxc`, `krita`, `libreoffice-fresh`, `obs-studio`, `onlyoffice-desktopeditors`, `proton-vpn`
- **Desktop & Wayland:** `darkman`, `gammastep`, `hyprshot`, `quickshell`, `wl-clipboard`
- **Development:** `git`, `neovim`, `nixd`, `nixfmt`
- **Shell & Terminal:** `bat`, `btop`, `eza`, `kitty`, `starship`, `yazi`, `zsh`
- **Gaming:** `Steam` with a dedicated Gamescope session
- **Utilities:** `brightnessctl`, `LocalSend`

GPU-aware packages such as `btop` and OBS are configured according to the active AMD or NVIDIA graphics backend.

## Installation & Deployment

Check the flake:

```bash
nix flake check
```

Build a configuration without activating it:

```bash
sudo nixos-rebuild build --flake .#<hostName>
```

Deploy it:

```bash
sudo nixos-rebuild switch --flake .#<hostName>
```

## Core Specifications

- **Architecture:** `x86_64-linux`
- **NixOS Channel:** `nixos-unstable`
- **Stable Package Overlay:** `nixos-26.05`
- **State Version:** `26.05`
