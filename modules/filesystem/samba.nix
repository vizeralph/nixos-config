let
  mount = share: {
    device = "//192.168.50.1/${share}";
    fsType = "cifs";
    options = [
      "credentials=/etc/samba/credentials"
      "gid=100"
      "noauto"
      "nodev"
      "noexec"
      "nofail"
      "nosuid"
      "seal"
      "uid=1000"
      "vers=3.1.1"
      "x-systemd.automount"
      "x-systemd.device-timeout=5s"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=5s"
    ];
  };
in
{
  fileSystems."/mnt/family" = mount "family";
  fileSystems."/mnt/personal" = mount "personal";
}
