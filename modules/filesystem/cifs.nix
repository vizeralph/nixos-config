let
  mount = share: {
    device = "//192.168.50.1/${share}";
    fsType = "cifs";
    options = [
      "credentials=/etc/samba/credentials"
      "gid=users"
      "nodev"
      "noexec"
      "nofail"
      "nosuid"
      "seal"
      "uid=vize"
      "vers=3.1.1"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=5s"
    ];
  };
in
{
  fileSystems."/mnt/family" = mount "family";
  fileSystems."/mnt/personal" = mount "personal";
}
