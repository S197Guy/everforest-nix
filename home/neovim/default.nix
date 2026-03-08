{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Link the config directory via XDG to prevent Nix store write errors
  xdg.configFile."nvim".source = ./config;

  home.packages = with pkgs; [
    gcc
    gnumake
    unzip
    wget
    curl
    nodejs
    gopls
    rust-analyzer
    nil
    alejandra
    kdlfmt
  ];
}
