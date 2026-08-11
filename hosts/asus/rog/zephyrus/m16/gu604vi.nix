{ self, ... }: {
  imports = [
    (self + "/modules")
    (self + "/modules/bootloader")
    (self + "/modules/networking")
    (self + "/modules/display-manager/ly.nix")
    (self + "/modules/filesystem/btrfs.nix")
    (self + "/modules/hardware/intel.nix")
    (self + "/modules/hardware/nvidia.nix")
  ];
  modules = {
    bootloader.type = "grub";
    filesystem.btrfs.swap = {
      size = 32 * 1024;
      type = "file";
    };
    hardware.intel = {
      cpu.enable = true;
      gpu.enable = true;
    };
  };
  boot.loader.efi.canTouchEfiVariables = true;
  hardware = {
    enableRedistributableFirmware = true;
    nvidia = {
      branch = "latest";
      open = true;
      powerManagement.finegrained = true;
      prime = {
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
        offload.enable = true;
      };
    };
  };
  networking = {
    hostName = "vize-zephyrus-m16-gu604vi";
    networkmanager.wifi.powersave = true;
  };
  services.asusd.enable = true;
  system.stateVersion = "26.05";
}
