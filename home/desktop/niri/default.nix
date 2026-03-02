{
  pkgs,
  ...
}: {
  home.file.".config/niri" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [
    xwayland
    wl-clipboard
    swww
  ];
}
