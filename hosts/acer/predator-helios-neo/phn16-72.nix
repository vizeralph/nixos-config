{ inputs, ... }:

{
  imports = [ (inputs.self + "/modules") ];

  modules.hardware = {
    cpu = [ "intel" ];
    gpu = [
      "intel"
      "nvidia"
    ];
  };

  boot.loader.efi.canTouchEfiVariables = true;
  hardware = {
    enableRedistributableFirmware = true;
    nvidia.prime = {
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
      offload.enable = true;
    };
  };
  nixpkgs.hostPlatform = "x86_64-linux";
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024;
    }
  ];
  system.stateVersion = "26.05";
}
