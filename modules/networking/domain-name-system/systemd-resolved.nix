{ config, lib, ... }:
let
  cfg = config.modules.networking.domainNameSystem;
in
{
  config = lib.mkIf (cfg.type == "systemd-resolved") {
    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNS = [
          "94.140.14.14#dns.adguard-dns.com"
          "94.140.15.15#dns.adguard-dns.com"
          "2a10:50c0::ad1:ff#dns.adguard-dns.com"
          "2a10:50c0::ad2:ff#dns.adguard-dns.com"

          "76.76.2.11#p2.freedns.controld.com"
          "76.76.10.11#p2.freedns.controld.com"
          "2606:1a40::11#p2.freedns.controld.com"
          "2606:1a40:1::11#p2.freedns.controld.com"
        ];
        DNSSEC = true;
        DNSOverTLS = true;
      };
    };
  };
}
