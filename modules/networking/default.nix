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
    description = "DNS resolver/proxy backend.";
  };

  config = lib.mkMerge [
    {
      networking = {
        networkmanager = {
          enable = true;
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
        zones.public.services = [ "dhcpv6-client" ];
      };
      users.users.vize.extraGroups = [ "networkmanager" ];
    }
    (lib.mkIf backends.${cfg.type} {
      networking = {
        nameservers = [
          "127.0.0.1"
          "::1"
        ];
        networkmanager.dns = "none";
      };
    })
  ];
}
