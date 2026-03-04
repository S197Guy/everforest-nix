{ pkgs, ... }: {
  # Symlink the entire niri config directory to ~/.config/niri
  # This is much cleaner and ensures all sub-config files in cfg/ are accessible.
  xdg.configFile."niri" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [
    xwayland
    wl-clipboard
    swww
    fuzzel
  ];
}
