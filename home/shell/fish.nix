{ pkgs, lib, ... }: {
  programs.fish.enable = true;
  
  # Add local npm binaries to path
  programs.fish.shellInit = "fish_add_path $HOME/.npm-global/bin";

  # Instead of linking the whole directory as a store symlink,
  # we link the files into the home directory where they remain writable.
  # Using mkForce ensures our config is the one used.
  xdg.configFile."fish/config.fish".source = lib.mkForce ./config/config.fish;
  
  # We use the recursive home.file approach but for the subdir to ensure writability
  # for things like fish_variables which Fish expects to be able to create.
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
