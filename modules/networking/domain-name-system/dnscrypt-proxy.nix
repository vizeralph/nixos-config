{ config, lib, ... }:
let
  cfg = config.modules.networking.domainNameSystem;
in
{
  config = lib.mkIf (cfg.type == "dnscrypt-proxy") {
    services.dnscrypt-proxy = {
      enable = true;
      settings = {
        server_names = [
          "adguard-dns-doh"
          "adguard-dns-doh-ipv6"

          "controld-block-malware-ad"
        ];
        listen_addresses = [
          "127.0.0.1:53"
          "[::1]:53"
        ];
        ipv6_servers = true;
        http3 = true;
      };
    };
  };
}
