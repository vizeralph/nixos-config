{ config, lib, ... }:
let
  cfg = config.modules.networking.domainNameSystem;
in
{
  config = lib.mkIf (cfg.type == "dnsproxy") {
    networking = {
      nameservers = [
        "127.0.0.1"
        "::1"
      ];
      networkmanager.dns = "none";
    };
    services.dnsproxy = {
      enable = true;
      settings = {
        listen-addrs = [
          "127.0.0.1"
          "::1"
        ];
        upstream = [ "quic://dns.adguard-dns.com" ];
        bootstrap = [
          "94.140.14.14:53"
          "94.140.15.15:53"
          "[2a10:50c0::ad1:ff]:53"
          "[2a10:50c0::ad2:ff]:53"
        ];
        fallback = [ "https://dns.adguard-dns.com/dns-query" ];
        ratelimit-subnet-len-ipv6 = 64;
        cache = true;
      };
    };
  };
}
