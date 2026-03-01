{
  pkgs,
  ...
}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.alacritty}/bin/alacritty";
        layer = "overlay";
      };
      colors = {
        background = "2b3339ff"; # Everforest background
        text = "d3c6aaff";
        selection = "323d43ff";
        selection-text = "d3c6aaff";
        border = "a7c080ff"; # Everforest green
      };
    };
  };
}
