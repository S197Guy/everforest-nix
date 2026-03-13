{pkgs, ...}: {
  programs.fish = {
    enable = true;
    enableStarship = true;
    # Add local npm binaries to path persistently
        interactiveShellInit = ''
      fish_add_path -g $HOME/.local/bin $HOME/bin $HOME/.cargo/bin $HOME/.go/bin $HOME/.npm-global/bin
      
      # Source custom fish config from the nix store path custom fish config from the nix store path
      source ${./config/config.fish}
    '';
  };

  # Let Home Manager manage the main config.fish to properly source session variables.

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

  home.packages = with pkgs; [eza fastfetch ripgrep bat fzf starship];
}
