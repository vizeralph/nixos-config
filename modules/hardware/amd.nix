{ config, lib, ... }:
let
  cfg = config.modules.hardware.amd;
in
{
  options.modules.hardware.amd = {
    cpu.enable = lib.mkEnableOption "AMD CPU support";
    gpu.enable = lib.mkEnableOption "AMD GPU support";
  };
  config = lib.mkMerge [
    (lib.mkIf cfg.cpu.enable {
      boot.kernelModules = [ "kvm-amd" ];
      hardware.cpu.amd.updateMicrocode = true;
    })
    (lib.mkIf cfg.gpu.enable {
      hardware.amdgpu.opencl.enable = true;
      services.xserver.videoDrivers = [ "amdgpu" ];
    })
  ];
}
