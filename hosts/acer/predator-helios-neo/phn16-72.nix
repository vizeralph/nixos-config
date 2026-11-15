{ inputs, ... }:

{
  imports = [ (inputs.self + "/modules") ];

  modules = {
    bootloader.type = "grub";
    filesystem.type = "btrfs";
    hardware = {
      cpu = [ "intel" ];
      gpu = [
        "intel"
        "nvidia"
      ];
    };
    networking.domainNameSystem.type = "dnsproxy";
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
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
  networking.hostName = "vize-helios-neo-phn16-72";
  nixpkgs.hostPlatform = "x86_64-linux";
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024;
    }
  ];
  system.stateVersion = "26.05";
}
