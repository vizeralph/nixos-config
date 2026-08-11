{ self, ... }: {
  imports = [
    (self + "/modules")
    (self + "/modules/bootloader")
    (self + "/modules/networking")
    (self + "/modules/display-manager/ly.nix")
    (self + "/modules/filesystem/btrfs.nix")
    (self + "/modules/hardware/amd.nix")
    (self + "/modules/hardware/nvidia.nix")
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
        offload.enable = true;
      };
    };
  };
  networking = {
    hostName = "vize-strix-scar-15-g533qr";
    networkmanager.wifi.powersave = true;
  };
  services.asusd.enable = true;
  system.stateVersion = "26.05";
}
