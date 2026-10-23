{ inputs, ... }:
{
  imports = [
    (inputs.self + "/modules")
    (inputs.self + "/modules/filesystem/btrfs.nix")
    (inputs.self + "/modules/hardware/intel.nix")
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
    networking.domainNameSystem.type = "dnsproxy";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  hardware.enableRedistributableFirmware = true;
  networking.hostName = "vize-yoga-7-14irl8";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";
}
