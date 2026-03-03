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
    stateVersion = "25.11";
  };

  home.packages = with pkgs; [
    # Core tools
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
    
    # Productivity & Media
    discord
    obs-studio
    mpv
    vlc
    zathura
    kdePackages.okular
    remmina
    librewolf
    ranger
    meld
    
    # Gaming Tools
    lutris
    moonlight-qt
    protonplus
    
    # Virtualization/Containers UI
    podman-desktop
    virt-viewer

    # Custom Apps/Utils (Config Only for now)
  ];

  # Symlink Noctalia config
    recursive = true;
  };

  programs.home-manager.enable = true;
}
