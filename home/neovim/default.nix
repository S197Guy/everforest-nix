{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Link the config directory via XDG to prevent Nix store write errors
  xdg.configFile."nvim".source = ./config;

    home.packages = with pkgs; [
    unzip # Specifically needed for some neovim plugin manual installs
  ];
}
