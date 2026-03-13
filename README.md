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

---

## 🛠 Maintenance Guide

### 🚀 Common Commands

| Task | Command |
| :--- | :--- |
| **Apply Changes** | `sudo nh os switch ~/.everforest-nix` |
| **Update Software** | `nix flake update` (followed by Apply Changes) |
| **Cleanup Old Versions** | `nh clean all --keep 5` |
| **Validate Niri Config** | `niri validate --config ~/.config/niri/config.kdl` |
| **Nix Syntax Check** | `nix-instantiate --parse file.nix` |

### 📋 Best Practices

1. **The "Two-Step" Update**
   - Config changes are instant with `nh os switch`.
   - To get new software versions, you MUST run `nix flake update` first to refresh the `flake.lock`.

2. **Stability & Recovery**
   - **Boot Menu:** If an update breaks something (like a driver), just reboot and select a previous "Generation" from the boot menu.
   - **Undo:** Since this is a Git repo, use `git restore <file>` to undo mistakes before you commit them.

3. **Disk Space**
   - Old generations stick around forever until you run `nh clean`. 
   - **Rule of Thumb:** Use the system for a day after a big update before cleaning up old generations.

4. **The `stateVersion` Rule**
   - `system.stateVersion = "25.11"` (found in `modules/system.nix`) should **NEVER** be changed. It ensures your data remains compatible with how it was originally written to disk.

5. **LSP & Formatting**
   - **Nix:** Files are automatically formatted on save using `alejandra`.
   - **KDL (Niri):** Files are automatically formatted on save using `kdlfmt`.

### 🎨 Themes & Customization
- **Prompt:** Managed in `home/shell/starship.nix` (Everforest Hard palette).
- **Wallpaper:** Set in `home/desktop/niri/config/config.kdl` using `swww`.
- **GTK/Icons:** Managed in `home/style/gtk.nix`.
