{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.hardware.intel;
in
{
  options.modules.hardware.intel = {
    cpu.enable = lib.mkEnableOption "Intel CPU support";
    gpu.enable = lib.mkEnableOption "Intel GPU support";
  };
  config = lib.mkMerge [
    (lib.mkIf cfg.cpu.enable {
      boot.kernelModules = [ "kvm-intel" ];
      hardware.cpu.intel.updateMicrocode = true;
    })
    (lib.mkIf cfg.gpu.enable {
      hardware.graphics.extraPackages = [
        pkgs.intel-compute-runtime
        pkgs.intel-media-driver
        pkgs.libvdpau-va-gl
        pkgs.vpl-gpu-rt
      ];
      services.xserver.videoDrivers = [ "modesetting" ];
    })
  ];
}
