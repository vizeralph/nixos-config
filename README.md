# nixos-config

> **Ex dissatisfactione, evolutio.**  
> *(Out of dissatisfaction, evolution.)*

My personal, flake-based NixOS configuration.

The repository is structured around multiple hosts backed by reusable modules, with machine-specific configuration kept
separate from the shared system and userland baseline.

This is primarily maintained for my own systems and preferences rather than as a general-purpose NixOS distribution.
The configuration is nevertheless kept modular and inspectable enough to reuse or adapt where appropriate.

## Structure

```text
.
├── hosts/      # Machine-specific configurations
├── modules/    # Shared and reusable system modules
├── flake.lock
└── flake.nix
```

Available NixOS configurations can be inspected with:

```bash
nix flake show
```

## Installation

From a NixOS installation environment, prepare and mount the target filesystems under `/mnt`, then install the desired
configuration:

```bash
sudo nixos-install --flake .#<host>
```

The host name corresponds to an entry under `nixosConfigurations` in `flake.nix`.

## Deployment

Check the flake:

```bash
nix flake check
```

Build a configuration without activating it:

```bash
sudo nixos-rebuild build --flake .#<host>
```

Build and activate it:

```bash
sudo nixos-rebuild switch --flake .#<host>
```
