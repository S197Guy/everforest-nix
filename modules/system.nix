{pkgs, ...}: let
  greetd-niri-config = pkgs.writeText "greetd-niri-config" ''
    output "DP-1" {
        mode "2560x1440@164.802"
    }
    output "DP-2" {
        off
    }

    hotkey-overlay {
        skip-at-startup
    }

    window-rule {
        match app-id="Alacritty"
        open-fullscreen true
    }

    window-rule {
        geometry-corner-radius 0
    }
  '';
in {
  # 1. Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # 2. Kernel & GPU (AMD Optimized)
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["amdgpu.ppfeaturemask=0xfffd7fff"];
  boot.initrd.kernelModules = ["amdgpu"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  # 3. Networking & Discovery
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.xone.enable = true;
  services.blueman.enable = true;

  services.gvfs.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };
  services.samba = {
    enable = true;
    openFirewall = true;
  };
  services.samba-wsdd.enable = true;

  # 5. Zram Swap (Match CachyOS)
  zramSwap.enable = true;

  # 6. Audio (Pipewire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # 7. Virtualisation & Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  programs.virt-manager.enable = true;

  # 8. Gaming Support
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;
  programs.corectrl.enable = true;

  # 9. User Setup
  users.users.neonscar = {
    isNormalUser = true;
    description = "neonscar";
    extraGroups = ["networkmanager" "wheel" "video" "input" "libvirtd"];
    shell = pkgs.fish;
  };

  # 10. System-wide packages
  environment.systemPackages = with pkgs; [
    ebtables
    dnsmasq
    git
    neovim
    curl
    wget
    pciutils
    usbutils
    btrfs-progs
    btrfs-assistant
    snapper
    bolt
    nix-output-monitor
    nh
    duf
    glances
    smartmontools
    upower
    unrar
    unzip
    cifs-utils
    samba
    amdgpu_top
    corectrl
    gh
    networkmanager-openvpn
    vulkan-loader
    vulkan-tools
    zenity
    kdePackages.kdialog
  ];

  programs.fish.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka
  ];

  # 11. Nix Settings & Experimental Features
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.niri}/bin/niri --config ${greetd-niri-config} -- ${pkgs.alacritty}/bin/alacritty -e ${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session --theme 'border=#a7c080;text=#d3c6aa;prompt=#83c092;time=#e67e80;action=#7fbbb3;button=#dbbc7f;container=#323c41;input=#d3c6aa'";
        user = "greeter";
      };
    };
  };
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://niri.cachix.org"];
    trusted-public-keys = ["niri.cachix.org-1:Wv0Om607ZpS6cq979S0WNoX57H96p7nC9i0i+V35uYk="];
  };

  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";

  # 12. Desktop Portals (Fixes file pickers and app crashes)
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common.default = ["gtk"];
      niri.default = ["gtk" "gnome"];
    };
  };

  system.stateVersion = "25.11";
  # Ensure libvirt default network is active and autostarts
  systemd.services.libvirt-net-autostart = {
    description = "Configure libvirt default network";
    after = ["libvirtd.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${pkgs.libvirt}/bin/virsh net-start default || true
      ${pkgs.libvirt}/bin/virsh net-autostart default || true
    '';
  };
}
