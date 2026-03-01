{
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
  };

  # Symlink the copied alacritty config files
  home.file.".config/alacritty" = {
    source = ./config;
    recursive = true;
  };
}
