{ pkgs, ... }:

{
  imports = [
    ./searx

    ./dnsproxy.nix
    ./ly.nix
  ];

  services = {
    automatic-timezoned.enable = true;
    flatpak.enable = true;
    pipewire = {
      alsa.support32Bit = true;
      jack.enable = true;
    };
    power-profiles-daemon.enable = true;
    printing.enable = true;
    upower.enable = true;
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
    };
  };
}
