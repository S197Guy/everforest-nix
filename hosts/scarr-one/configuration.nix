{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/system.nix
    ./hardware-configuration.nix
    ./extra-mounts.nix
  ];

  networking.hostName = "scarr-one";

  # Specific system-wide programs
  programs.niri.enable = true;

  # Standardize on fuzzel for niri
    environment.systemPackages = with pkgs; [
    fuzzel
    waybar
    swww
  ];

  system.stateVersion = "25.11";
}
