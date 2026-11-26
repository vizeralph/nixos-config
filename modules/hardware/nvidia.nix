{ config, lib, ... }:
let
  cfg = config.modules.hardware;
  offload = config.hardware.nvidia.prime.offload.enable;
in
{
  config = lib.mkIf (lib.elem "nvidia" cfg.gpu) {
    hardware.nvidia = {
      branch = lib.mkDefault "latest";
      dynamicBoost.enable = lib.mkDefault true;
      moduleParams.nvidia.NVreg_EnableS0ixPowerManagement = lib.mkDefault 1;
      open = lib.mkDefault true;
      powerManagement = {
        enable = lib.mkDefault true;
        finegrained = lib.mkDefault offload;
      };
      prime.offload.enableOffloadCmd = lib.mkDefault offload;
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
  };
}
