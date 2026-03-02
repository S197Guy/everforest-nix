{
  pkgs,
  ...
}: {
  # 1. Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # 2. Kernel & GPU (AMD Optimized)
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xfffd7fff" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-runtime
    ];
  };

  # 3. Networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # 4. Audio (Pipewire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # 5. Virtualisation
  virtualisation.libvirtd.enable = true;

  # 6. User Setup
  users.users.neonscar = {
    isNormalUser = true;
    description = "neonscar";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "libvirtd" ];
    shell = pkgs.fish;
  };

  # 7. System-wide packages
  environment.systemPackages = with pkgs; [
    git
    neovim
    curl
    wget
    pciutils
    usbutils
    btrfs-progs
    bolt
    # Nix helpers
    nix-output-monitor
    nh # Nix Helper
  ];

  programs.fish.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # 8. Experimental Features (for Flakes)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # 9. Timezone & Locale
  time.timeZone = "America/Denver"; # Adjusted based on your timestamps
  i18n.defaultLocale = "en_US.UTF-8";

  # 10. State Version
  system.stateVersion = "25.11";
}
