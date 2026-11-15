{ lib, ... }:

{
  i18n.defaultLocale = "en_PH.UTF-8";
  location = {
    latitude = 13.0;
    longitude = 122.0;
    provider = "geoclue2";
  };
  networking.timeServers = [
    "ph.pool.ntp.org"
    "asia.pool.ntp.org"
  ];
  services = {
    automatic-timezoned.enable = true;
    geoclue2 = {
      enableStatic = true;
      enableWifi = lib.mkForce true;
      staticAccuracy = 25000;
      staticAltitude = 0;
    };
  };
  # HACK: fixes gio deadlock.
  # https://go.mail-archive.com/ubuntu-bugs@lists.ubuntu.com/msg6330971.html
  systemd.services.geoclue.serviceConfig.Environment = "GIO_USE_PROXY_RESOLVER=dummy";
  time.timeZone = lib.mkDefault "Asia/Manila";
}
