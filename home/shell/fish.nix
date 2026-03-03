{ pkgs, ... }: {
  programs.fish.enable = true;
  
  # Link individual config files instead of the whole directory
  xdg.configFile."fish/config.fish".source = ./config/config.fish;
  xdg.configFile."fish/functions".source = ./config/functions;
  xdg.configFile."fish/conf.d".source = ./config/conf.d;

  home.packages = with pkgs; [ eza fastfetch ripgrep bat fzf starship ];
}
