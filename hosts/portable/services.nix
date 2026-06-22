{
  services = {
    asusd.enable = true;
    xserver.videoDrivers = [
      "amdgpu"
      "fbdev"
      "modesetting"
      "nvidia"
    ];
  };
}
