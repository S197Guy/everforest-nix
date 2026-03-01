{
  pkgs,
  inputs,
  ...
}: {
  # Import system modules
  # imports = [ ./hardware-configuration.nix ]; # To be generated

  # Bootloader (Systemd-boot is standard for UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel & Modules (Ryzen 5800X3D & RX 6900XT)
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xfffd7fff" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Networking & Hardware
  networking.hostName = "scarr-one";
  networking.networkmanager.enable = true;
  
  # Bluetooth Support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Graphics Drivers (AMD)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

  # Audio (Pipewire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # User Account
  users.users.neonscar = {
    isNormalUser = true;
    description = "neonscar";
  virtualisation.libvirtd.enable = true;
    extraGroups = [ "networkmanager" "wheel" "video" "input" "libvirtd" ];
    shell = pkgs.fish;
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    git
    neovim
    curl
    wget
    pciutils
    usbutils
    btrfs-progs
    bolt # Thunderbolt 3 support
  ];

  # Shell Integration
  programs.fish.enable = true;

  # Fonts (System Profile)
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
  ];

  # State Version
  # Set Neovim as the default editor
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  system.stateVersion = "23.11";
}
