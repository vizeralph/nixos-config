{ inputs, ... }:

{
  imports = [
    (inputs.self + "/modules")
    (inputs.self + "/modules/filesystem/ext4.nix")
  ];

  modules.filesystem.ext4.swap.type = "partition";

  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "vize-vm";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";
}
