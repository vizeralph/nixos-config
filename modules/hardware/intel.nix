{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkMerge [
    (lib.mkIf (lib.elem "intel" config.modules.hardware.cpu) {
      boot.kernelModules = [ "kvm-intel" ];
      hardware.cpu.intel.updateMicrocode = true;
    })

    (lib.mkIf (lib.elem "intel" config.modules.hardware.gpu) {
      hardware.graphics.extraPackages = [
        pkgs.intel-compute-runtime
        pkgs.intel-media-driver
        pkgs.vpl-gpu-rt
      ];
      services.xserver.videoDrivers = [ "modesetting" ];
    })
  ];
}
