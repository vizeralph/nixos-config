{ config, lib, ... }:
let
  cfg = config.modules.networking.domainNameSystem;
  backends = {
    dnscrypt-proxy = true;
    dnsproxy = true;
    systemd-resolved = false;
    none = false;
  };
in
{
  imports = [
    ./domain-name-system/dnscrypt-proxy.nix
    ./domain-name-system/dnsproxy.nix
    ./domain-name-system/systemd-resolved.nix
  ];

  options.modules.networking.domainNameSystem.type = lib.mkOption {
    type = lib.types.enum (builtins.attrNames backends);
    default = "dnscrypt-proxy";
  };

  config = {
    networking = {
      nameservers = lib.mkIf backends.${cfg.type} [
        "127.0.0.1"
        "::1"
      ];
      networkmanager = {
        dns = lib.mkIf backends.${cfg.type} "none";
        enable = true;
        settings.connection = {
          "ipv4.dhcp-send-hostname" = 0;
          "ipv6.dhcp-send-hostname" = 0;
        };
        wifi = {
          backend = "iwd";
          macAddress = "random";
        };
      };
      nftables.enable = true;
    };
    services.firewalld = {
      enable = true;
      settings.DefaultZone = "public";
      zones = {
        nixos-fw-default.services = [ "dhcpv6-client" ];
        public.services = [ "dhcpv6-client" ];
      };
    };
    users.users.vize.extraGroups = [ "networkmanager" ];
  };
}
