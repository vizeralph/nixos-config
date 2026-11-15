{ config, lib, ... }:

{
  config = lib.mkMerge [
    (lib.mkIf (lib.elem "amd" config.modules.hardware.cpu) {
      boot.kernelModules = [ "kvm-amd" ];
      hardware.cpu.amd.updateMicrocode = true;
    })

    (lib.mkIf (lib.elem "amd" config.modules.hardware.gpu) {
      hardware.amdgpu.opencl.enable = true;
      services.xserver.videoDrivers = [ "amdgpu" ];
    })
  ];
}
