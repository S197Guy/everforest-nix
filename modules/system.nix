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
      rocmPackages.clr.icd
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

  # 5. Virtualisation & Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  programs.virt-manager.enable = true;

  # 6. Gaming Support
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;

  # 7. User Setup
  users.users.neonscar = {
    isNormalUser = true;
    description = "neonscar";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "libvirtd" ];
    shell = pkgs.fish;
  };

  # 8. System-wide packages
  environment.systemPackages = with pkgs;
    [
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
      nh
      # Utilities from Everforest
      duf
      glances
      smartmontools
      upower
      unrar
      unzip
    ];

  programs.fish.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # 9. Nix Settings & Experimental Features
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
  };
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://niri.cachix.org" ];
    trusted-public-keys = [ "niri.cachix.org-1:Wv0Om607ZpS6cq979S0WNoX57H96p7nC9i0i+V35uYk=" ];
  };

  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "25.11";
}
