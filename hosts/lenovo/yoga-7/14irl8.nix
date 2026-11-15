{ inputs, ... }:

{
  imports = [ (inputs.self + "/modules") ];

  modules = {
    bootloader.type = "grub";
    filesystem.type = "btrfs";
    hardware = {
      cpu = [ "intel" ];
      gpu = [ "intel" ];
    };
    networking.domainNameSystem.type = "dnsproxy";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  hardware.enableRedistributableFirmware = true;
  networking.hostName = "vize-yoga-7-14irl8";
  nixpkgs.hostPlatform = "x86_64-linux";
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024;
    }
  ];
  system.stateVersion = "26.05";
}
