{
  imports = [
    ./dnsproxy.nix
    ./ly.nix
  ];

  services = {
    pipewire = {
      alsa.support32Bit = true;
      jack.enable = true;
    };
    power-profiles-daemon.enable = true;
  };
}
