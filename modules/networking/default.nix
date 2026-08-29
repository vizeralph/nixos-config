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
    default = "dnsproxy";
    description = "DNS resolver/proxy backend.";
  };
  config = {
    networking.networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        macAddress = "random";
      };
    };
    users.users.vize.extraGroups = [ "networkmanager" ];
  };
}
