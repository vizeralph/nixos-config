{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.bitwarden-desktop
    pkgs.keepassxc
    pkgs.proton-vpn
  ];
  services.clamav = {
    daemon = {
      enable = true;
      settings = {
        MaxScanSize = "2G";
        MaxFileSize = "2G";
        AlertExceedsMax = true;
      };
    };
    fangfrisch.enable = true;
    updater.enable = true;
  };
}
