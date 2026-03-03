{ pkgs, lib, ... }: {
  programs.fish.enable = true;
  
  # Use mkForce to override Home Manager's auto-generated config.fish
  xdg.configFile."fish/config.fish".source = lib.mkForce ./config/config.fish;
  
  # Link functions and conf.d
  xdg.configFile."fish/functions".source = ./config/functions;
  xdg.configFile."fish/conf.d".source = ./config/conf.d;
  xdg.configFile."fish/themes".source = ./config/themes;
  xdg.configFile."fish/completions".source = ./config/completions;

  home.packages = with pkgs; [ eza fastfetch ripgrep bat fzf starship ];
}
