{ config, lib, ... }:
let
  cfg = config.modules.hardware;
in
{
  config = lib.mkMerge [
    (lib.mkIf (lib.elem "amd" cfg.cpu) {
      boot.kernelModules = [ "kvm-amd" ];
      hardware.cpu.amd.updateMicrocode = true;
    })

    (lib.mkIf (lib.elem "amd" cfg.gpu) {
      hardware.amdgpu.opencl.enable = true;
      services.xserver.videoDrivers = [ "amdgpu" ];
    })
  ];
}
