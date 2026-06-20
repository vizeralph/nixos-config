{ config, lib, ... }:

{
  hardware = {
    amdgpu.opencl.enable = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableRedistributableFirmware = true;
    nvidia = {
      branch = "latest";
      open = true;
      powerManagement.enable = true;
    };
  };
}
