# Dotfiles

Git-tracked configuration for NixOS system with standalone Home Manager.

## Structure

- `flake.nix` - Main flake for NixOS + Home Manager
- `nixos/` - NixOS system configuration
  - `configuration.nix` - Main system config
  - `hardware-configuration.nix` - Hardware-specific config
- `home/` - Home Manager user configuration
  - `home.nix` - User packages and settings

## Setup

### 1. Update /etc/nixos/ to remove Home Manager module

```bash
sudo rm /etc/nixos/home.nix
sudoedit /etc/nixos/flake.nix
```

Replace the flake.nix content with:
```nix
{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = inputs@{ nixpkgs, ... }:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
          ];
        };
      };
    };
}
```

### 2. Rebuild NixOS

```bash
sudo nixos-rebuild switch --flake /home/fomar/dotfiles#nixos
```

### 3. Apply Home Manager (standalone)

```bash
home-manager switch --flake ~/dotfiles#fomar
```

## Usage

- Rebuild NixOS: `sudo nixos-rebuild switch --flake ~/dotfiles#nixos`
- Update Home Manager: `home-manager switch --flake ~/dotfiles#fomar`
- Update flake inputs: `nix flake update ~/dotfiles`

## First Time Setup

The first time you run home-manager switch, it will generate a flake.lock file.
