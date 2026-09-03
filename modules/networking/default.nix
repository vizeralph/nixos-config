{ lib, ... }: {
  imports = [
    ./domain-name-system/dnscrypt-proxy.nix
    ./domain-name-system/dnsproxy.nix
    ./domain-name-system/systemd-resolved.nix
  ];
  options.modules.networking.domainNameSystem.type = lib.mkOption {
    type = lib.types.enum [
      "dnscrypt-proxy"
      "dnsproxy"
      "systemd-resolved"
      "none"
    ];
    default = "dnscrypt-proxy";
    description = "DNS resolver/proxy backend.";
  };
  config = {
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
  };
}
