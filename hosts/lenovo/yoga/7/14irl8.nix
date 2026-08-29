{ self, ... }: {
  imports = [
    (self + "/modules")
    (self + "/modules/bootloader")
    (self + "/modules/networking")
    (self + "/modules/display-manager/ly.nix")
    (self + "/modules/filesystem/btrfs.nix")
    (self + "/modules/hardware/intel.nix")
  ];
  modules = {
    bootloader.type = "grub";
    filesystem.btrfs.swap = {
      size = 16 * 1024;
      type = "file";
    };
    hardware.intel = {
      cpu.enable = true;
      gpu.enable = true;
    };
  };
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.enableRedistributableFirmware = true;
  networking = {
    hostName = "vize-yoga-7-14irl8";
    networkmanager.wifi.powersave = true;
  };
  system.stateVersion = "26.05";
}
