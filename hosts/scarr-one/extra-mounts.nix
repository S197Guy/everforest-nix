{ ... }: {
  # Migration from CachyOS: Crucial Physical Drive
  fileSystems."/mnt/crucial" = {
    device = "/dev/disk/by-uuid/daaf2ae6-89a6-4ef2-964c-98359a61784c";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };

  # SMB Share (Neonsyn)
  fileSystems."/mnt/neonsyn" = {
    device = "//192.168.1.68/neonsyn";
    fsType = "cifs";
    options = let
      # this line prevents the system from failing if the NAS is offline
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,nofail";
    in [ "${automount_opts},credentials=/etc/samba/.neonsyn_creds,uid=1000,gid=1000,iocharset=utf8,rw,nobrl,vers=3.1.1" ];
  };
}
