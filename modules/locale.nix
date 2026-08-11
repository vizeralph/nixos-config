{ lib, ... }: {
  i18n = {
    defaultLocale = "en_PH.UTF-8";
    extraLocales = [ "en_US.UTF-8/UTF-8" ];
  };
  location.provider = "geoclue2";
  networking.timeServers = [
    "ph.pool.ntp.org"
    "asia.pool.ntp.org"
  ];
  services.automatic-timezoned.enable = true;
  time.timeZone = lib.mkDefault "Asia/Manila";
}
