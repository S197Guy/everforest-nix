{
  inputs,
  pkgs,
  ...
}: {
  # Import modular home configurations
  imports = [
    ./desktop/waybar.nix
    ./desktop/launcher.nix
    ./desktop/niri
    ./terminal/alacritty.nix
    ./style/gtk.nix
    ./shell/fish.nix
    ./neovim
  ];

  home = {
    username = "neonscar";
    homeDirectory = "/home/neonscar";
    stateVersion = "23.11"; # Default NixOS state version
  };

  # Packages that do not have a dedicated module
  home.packages = with pkgs; [
    # Core System Utils
    btop
    eza
    ripgrep
    bat
    jq
    rsync
    wget
    curl
    wl-clipboard
    cliphist
    nautilus
    fastfetch
    
    # Connectivity
    networkmanagerapplet
    blueman
    

  programs.home-manager.enable = true;
}
