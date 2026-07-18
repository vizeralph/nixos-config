{
  networking = {
    dhcpcd.enable = false;
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    networkmanager = {
      dns = "none";
      enable = true;
      wifi = {
        backend = "iwd";
        macAddress = "random";
      };
    };
    timeServers = [
      "ph.pool.ntp.org"
      "asia.pool.ntp.org"
    ];
  };
}
