{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 4;
        modules-left = [ "custom/launcher" "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "pulseaudio" "cpu" "memory" "network" ];

        "custom/launcher" = {
          format = " 󱓟 ";
          on-click = "fuzzel";
          tooltip = false;
        };

        "niri/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };

        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "pavucontrol";
        };

        "tray" = {
          spacing = 10;
        };
      };
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
      }
      window#waybar {
        background: #2b3339; /* Everforest Background */
        color: #d3c6aa;      /* Everforest Foreground */
        border-bottom: 2px solid #a7c080; /* Everforest Green */
      }
      #workspaces button {
        padding: 0 5px;
        color: #7a8478;
      }
      #workspaces button.active {
        color: #a7c080;
      }
      #workspaces button.urgent {
        color: #e67e80;
      }
      #custom-launcher {
        color: #a7c080;
        padding-left: 10px;
        padding-right: 5px;
      }
      #clock, #pulseaudio, #cpu, #memory, #network, #tray {
        padding: 0 10px;
      }
    '';
  };
}
