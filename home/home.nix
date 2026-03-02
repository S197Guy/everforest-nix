{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./desktop/waybar.nix
    ./desktop/launcher.nix
    ./desktop/niri/default.nix
    ./terminal/alacritty.nix
    ./style/gtk.nix
    ./shell/fish.nix
    ./neovim/default.nix
  ];

  home = {
    username = "neonscar";
    homeDirectory = "/home/neonscar";
    stateVersion = "23.11";
  };

  home.packages = with pkgs; [
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
    networkmanagerapplet
    blueman
  ];

  programs.home-manager.enable = true;
}
