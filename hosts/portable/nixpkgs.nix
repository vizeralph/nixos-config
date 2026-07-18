{
  nixpkgs.config.allowUnfreePackages = [
    "intel-ocl"
    "nvidia-settings"
    "nvidia-x11"
  ];
}
