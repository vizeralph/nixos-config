{
  hardware.nvidia = {
    # FIXME: patchelf regression
    # https://github.com/NixOS/nixpkgs/issues/576435
    # dynamicBoost.enable = true;
    moduleParams.nvidia.NVreg_EnableS0ixPowerManagement = 1;
    powerManagement.enable = true;
  };
  nixpkgs.config.allowUnfreePackages = [
    "nvidia-settings"
    "nvidia-x11"
  ];
  services.xserver.videoDrivers = [ "nvidia" ];
}
