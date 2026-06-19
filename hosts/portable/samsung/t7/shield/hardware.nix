{
  config,
  lib,
  pkgs,
  ...
}:

{
  hardware = {
    amdgpu.opencl.enable = true;
    cpu = {
      amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
    enableAllHardware = true;
    graphics.extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      intel-ocl
      libvdpau-va-gl
      vpl-gpu-rt
    ];
    nvidia = {
      branch = "latest";
      open = true;
    };
  };
}
