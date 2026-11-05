{
  hardware.nvidia = {
    dynamicBoost.enable = true;
    moduleParams.nvidia.NVreg_EnableS0ixPowerManagement = 1;
    powerManagement.enable = true;
  };
  nix.settings = {
    substituters = [ "https://cache.nixos-cuda.org" ];
    trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
  };
  nixpkgs.config.allowUnfreePackages = [
    "nvidia-settings"
    "nvidia-x11"
  ];
  services.xserver.videoDrivers = [ "nvidia" ];
}
