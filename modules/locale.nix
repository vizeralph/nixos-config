{ lib, ... }: {
  i18n = {
    defaultLocale = "en_PH.UTF-8";
    extraLocales = [ "en_US.UTF-8/UTF-8" ];
  };
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
      staticAccuracy = 25000;
      staticAltitude = 0;
    };
  };
  time.timeZone = lib.mkDefault "Asia/Manila";
}
