{
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    # We will use Waybar to provide the status info
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "cpu" "memory" "pulseaudio" "tray" ];
      };
    };
    style = ""; # We can add Everforest CSS here later
  };
}
