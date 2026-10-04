let
  mount = share: {
    device = "//192.168.50.1/${share}";
    fsType = "cifs";
    options = [
      "nodev"
      "noexec"
      "nofail"
      "nosuid"

      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=5s"

      "uid=vize"
      "gid=users"

      "credentials=/etc/samba/credentials"
      "seal"
      "vers=3.1.1"
    ];
  };
in
{
  fileSystems."/mnt/family" = mount "family";
  fileSystems."/mnt/personal" = mount "personal";
}
