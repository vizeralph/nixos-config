{ inputs, ... }:

{
  imports = [ (inputs.self + "/modules") ];

  modules.hardware = {
    cpu = [ "intel" ];
    gpu = [ "intel" ];
  };

  boot.loader.efi.canTouchEfiVariables = true;
  hardware.enableRedistributableFirmware = true;
  nixpkgs.hostPlatform = "x86_64-linux";
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024;
    }
  ];
  system.stateVersion = "26.05";
}
