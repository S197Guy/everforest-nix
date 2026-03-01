# everforest-nix

A declarative NixOS configuration for the Everforest Niri desktop.

## Target Machine
- **CPU:** Ryzen 7 5800X3D
- **GPU:** Radeon RX 6900XT (Navi 21)
- **Motherboard:** Asrock X570 Phantom Gaming-ITX/TB3

## Structure
- `flake.nix`: System entry point.
- `hosts/`: Machine-specific configurations.
- `modules/`: Reusable NixOS modules.
- `home/`: User-level configuration (Home Manager).
