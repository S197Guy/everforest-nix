{
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # We will use your existing nvim configuration
    # to maintain compatibility during the transition.
    # Symlink the config/nvim directory to ~/.config/nvim
    # using home.file instead of direct nix-config.
  };

  # Symlink the copied neovim config files
  home.file.".config/nvim" = {
    source = ./config;
    recursive = true;
  };

  # Ensure neovim dependencies are in the user profile
  home.packages = with pkgs; [
    gcc
    gnumake
    unzip
    wget
    curl
    nodejs
    npm
    # Language Servers
    gopls
    rust-analyzer
    nil
  ];
}
