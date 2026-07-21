{
  imports = [
    ./dnsproxy.nix
    ./ly.nix
  ];

  services = {
    automatic-timezoned.enable = true;
    pipewire = {
      alsa.support32Bit = true;
      jack.enable = true;
    };
    power-profiles-daemon.enable = true;
    printing.enable = true;
    upower.enable = true;
    xserver.enable = true;
  };
}
