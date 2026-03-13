{ ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = ''[ ](bg:#2d353b)$username$hostname$directory$git_branch$git_status$character'';
      
      # Everforest Color Palette (Hard)
      # bg: #2d353b
      # green: #a7c080
      # blue: #7fbbb3
      # red: #e67e80
      # orange: #e69875

      username = {
        show_always = true;
        style_user = "bg:#2d353b fg:#a7c080";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        style = "bg:#2d353b fg:#7fbbb3";
        format = "[@$hostname]($style) ";
      };

      directory = {
        style = "bg:#2d353b fg:#dbbc7f";
        format = "[$path]($style) ";
        truncation_length = 3;
        truncation_symbol = "../";
      };

      git_branch = {
        symbol = " ";
        style = "bg:#2d353b fg:#a7c080";
        format = "[on $symbol$branch]($style) ";
      };

      git_status = {
        style = "bg:#2d353b fg:#e67e80";
        ahead = "⇡ ";
        behind = "⇣ ";
        diverged = "⇕ ";
        up_to_date = "";
        format = "([$all_status$ahead_behind]($style))";
      };

      character = {
        success_symbol = "[λ ](bold fg:#a7c080)";
        error_symbol = "[λ ](bold fg:#e67e80)";
      };
    };
  };
}
