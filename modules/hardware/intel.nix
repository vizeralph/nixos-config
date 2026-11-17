{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.hardware;
in
{
  config = lib.mkMerge [
    (lib.mkIf (lib.elem "intel" cfg.cpu) {
      boot.kernelModules = [ "kvm-intel" ];
      hardware.cpu.intel.updateMicrocode = true;
    })

    (lib.mkIf (lib.elem "intel" cfg.gpu) {
      hardware.graphics.extraPackages = [
        pkgs.intel-compute-runtime
        pkgs.intel-media-driver
        pkgs.vpl-gpu-rt
      ];
      services.xserver.videoDrivers = [ "modesetting" ];
    })
  ];
}
