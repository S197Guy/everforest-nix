{
  inputs,
  pkgs, config,
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
    sessionPath = [ "$HOME/.npm-global/bin" ];
    homeDirectory = "/home/neonscar";
    stateVersion = "25.11";
    sessionVariables = {
      NPM_CONFIG_PREFIX = "$HOME/.npm-global";
    };
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
    pavucontrol
    swaylock-effects
    wlogout
    
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

    # Development Stack
    go
    gopls
    nodejs
    python3
    rustc
    cargo
    rust-analyzer
    nil # Nix LSP
    gcc
    gnumake
  ];

  home.file.".npmrc".text = "prefix=${config.home.homeDirectory}/.npm-global";
  programs.home-manager.enable = true;
}
