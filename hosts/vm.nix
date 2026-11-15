{ inputs, ... }:

{
  imports = [ (inputs.self + "/modules") ];

  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "vize-vm";
  nixpkgs.hostPlatform = "x86_64-linux";
  swapDevices = [ { device = "/var/lib/swapfile"; } ];
  system.stateVersion = "26.05";
}
