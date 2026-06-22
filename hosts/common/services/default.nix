{
  imports = [
    ./dnsproxy.nix
    ./ly.nix
  ];

  services = {
    pipewire = {
      alsa = {
        enable = true;
        support32Bit = true;
      };
      enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    power-profiles-daemon.enable = true;
  };
}
