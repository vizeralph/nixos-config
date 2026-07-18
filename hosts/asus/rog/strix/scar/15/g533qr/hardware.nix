{
  hardware = {
    amdgpu.opencl.enable = true;
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    nvidia = {
      branch = "latest";
      dynamicBoost.enable = true;
      open = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        amdgpuBusId = "PCI:6@0:0:0";
        nvidiaBusId = "PCI:1@0:0:0";
        offload.enable = true;
      };
    };
  };
}
