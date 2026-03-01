{
  pkgs,
  ...
}: {
  # Import Niri package from the flake input (defined in flake.nix)
  # This maps your copied .kdl files to the expected NixOS location
  home.file.".config/niri" = {
    source = ./config;
    recursive = true;
  };

  # Ensure Niri and its dependencies are in the user profile
  home.packages = with pkgs; [
    xwayland
    wl-clipboard
    swww
    # noctalia-shell # These may need custom packaging if not in nixpkgs
    # noctalia-qs
  ];
}
