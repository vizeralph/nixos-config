{ pkgs, ... }:

{
  hardware = {
    amdgpu.opencl.enable = true;
    cpu = {
      amd.updateMicrocode = true;
      intel.updateMicrocode = true;
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
      dynamicBoost.enable = true;
      open = true;
      powerManagement.enable = true;
    };
  };
}
