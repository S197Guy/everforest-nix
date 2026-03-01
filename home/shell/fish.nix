{
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
    # Home Manager can manage fish directly, but we will source your existing config.fish
    # to maintain compatibility during the transition.
    interactiveShellInit = "source ~/.config/fish/config.fish";
  };

  # Symlink the copied fish config files
  home.file.".config/fish" = {
    source = ./config;
    recursive = true;
  };

  # Ensure fish shell dependencies are in the user profile
  home.packages = with pkgs; [
    eza
    fastfetch
    ripgrep
    bat
    fzf
    starship
  ];
}
