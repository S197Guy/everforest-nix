{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xfffd7fff" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  networking.hostName = "scarr-one";
  networking.networkmanager.enable = true;
  
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  virtualisation.libvirtd.enable = true;

  users.users.neonscar = {
    isNormalUser = true;
    description = "neonscar";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "libvirtd" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
    curl
    wget
    pciutils
    usbutils
    btrfs-progs
    bolt
  ];

  programs.fish.enable = true;

  fonts.packages = with pkgs; [ 
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  system.stateVersion = "25.11";
}
