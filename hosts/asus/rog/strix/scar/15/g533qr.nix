{ inputs, ... }: {
  imports = [
    (inputs.self + "/modules")
    (inputs.self + "/modules/bootloader")
    (inputs.self + "/modules/display-manager/ly.nix")
    (inputs.self + "/modules/filesystem/btrfs.nix")
    (inputs.self + "/modules/filesystem/cifs.nix")
    (inputs.self + "/modules/hardware/amd.nix")
    (inputs.self + "/modules/hardware/nvidia.nix")
    (inputs.self + "/modules/networking")
  ];
  modules = {
    bootloader.type = "grub";
    filesystem.btrfs.swap = {
      size = 16 * 1024;
      type = "file";
    };
    hardware.amd = {
      cpu.enable = true;
      gpu.enable = true;
    };
    networking.domainNameSystem.type = "dnsproxy";
  };
  boot = {
    kernelParams = [ "processor.max_cstate=1" ];
    loader.efi.canTouchEfiVariables = true;
  };
  hardware = {
    enableRedistributableFirmware = true;
    nvidia = {
      branch = "latest";
      open = true;
      powerManagement.finegrained = true;
      prime = {
        amdgpuBusId = "PCI:6@0:0:0";
        nvidiaBusId = "PCI:1@0:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
  networking.hostName = "vize-strix-scar-15-g533qr";
  services.asusd.enable = true;
  system.stateVersion = "26.05";
}
