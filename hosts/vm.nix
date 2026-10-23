{ inputs, ... }:
{
  imports = [
    (inputs.self + "/modules")
    (inputs.self + "/modules/filesystem/ext4.nix")
  ];

  modules = {
    bootloader.type = "grub";
    filesystem.ext4.swap = {
      size = 16 * 1024;
      type = "file";
    };
    networking.domainNameSystem.type = "dnsproxy";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "vize-vm";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";
}
