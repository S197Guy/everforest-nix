{ pkgs, lib, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Add local npm binaries to path persistently
      fish_add_path -g /home/neonscar/.npm-global/bin
    '';
  };

  # Link the config files while maintaining writability for the directory
  xdg.configFile."fish/config.fish".source = lib.mkForce ./config/config.fish;
  
  home.file.".config/fish/functions" = {
    source = ./config/functions;
    recursive = true;
  };
  home.file.".config/fish/conf.d" = {
    source = ./config/conf.d;
    recursive = true;
  };
  home.file.".config/fish/completions" = {
    source = ./config/completions;
    recursive = true;
  };
  home.file.".config/fish/themes" = {
    source = ./config/themes;
    recursive = true;
  };

  home.packages = with pkgs; [ eza fastfetch ripgrep bat fzf starship ];
}
