{ lib, ... }: {
  imports = [
    ./dnscrypt-proxy.nix
    ./dnsproxy.nix
    ./systemd-resolved.nix
  ];
  options.modules.dns.type = lib.mkOption {
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
