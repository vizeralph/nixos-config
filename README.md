# nixos-config

> **Ex dissatisfactione, evolutio.**  
> _(Out of dissatisfaction, evolution.)_

My personal, flake-based NixOS configurations. Born out of systemic dissatisfaction with imperative operating systems, this repository represents a continuous evolution toward a predictable, reproducible, and highly optimized desktop environment.

Tailored for high-performance devices while maintaining a resilient, hardware-agnostic target for portable environments.

## System Architecture

This repository uses a modular multi-host setup split into individual system features and a common profile shared across all configurations:

```text
├── flake.nix
├── hosts/
│   ├── common/
│   ├── asus/
│   └── portable/
```

## Feature Highlights

- **Display Manager:** Deploys `ly`, a lightweight text-based user interface display manager configured with an animated **colormix** background.
- **Domain Name System:** Handles local DNS caching and ad-blocking using `dnsproxy` via encrypted **DNS-over-QUIC** to AdGuard.
- **System Maintenance:** Enforces deterministic system cleanup via automated garbage collection every **Monday** and store optimizations every **Friday**.
- **Window Manager:** Leverages `Hyprland` to provide a highly dynamic, fluid, and customized Wayland desktop compositor experience.

## System Packages

The core user workspace environment packages defined in **hosts/common/environment.nix**:

- **Daily Drivers & Security:** `bitwarden-desktop`, `firefox`, `keepassxc`
- **Desktop Environment & Theming:** `bibata-cursors`, `darkman`, `gammastep`, `qt6.qtdeclarative`, `quickshell`
- **Development & Tooling:** `git`, `lua-language-server`, `neovim`, `nix-diff`, `nixd`, `nixfmt`, `stylua`, `vscode`
- **Gaming:** `gamescope`, `steam`
- **Shell Utilities:** `bat`, `eza`, `kitty`, `starship`, `wl-clipboard`, `yazi`, `zsh`

## Installation & Deployment

```bash
sudo nixos-rebuild switch --flake .#<hostName>
```

## Core Specifications

- **State Version:** 26.05
