{ config, lib, ... }:
let
  cfg = config.modules.networking.domainNameSystem;
in
{
  config = lib.mkIf (cfg.type == "dnscrypt-proxy") {
    networking = {
      nameservers = [
        "127.0.0.1"
        "::1"
      ];
      networkmanager.dns = "none";
    };
    services.dnscrypt-proxy = {
      enable = true;
      settings = {
        server_names = [
          "adguard-dns-doh"
          "adguard-dns-doh-ipv6"
        ];
        listen_addresses = [
          "127.0.0.1:53"
          "[::1]:53"
        ];
        ipv6_servers = true;
        require_dnssec = true;
      };
    };
  };
}
