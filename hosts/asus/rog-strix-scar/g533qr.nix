{ inputs, ... }:

{
  imports = [
    (inputs.self + "/modules")
    (inputs.self + "/modules/filesystem/cifs.nix")
    (inputs.self + "/modules/patches/speaker-headphone-routing.nix")
  ];

  modules = {
    bootloader.type = "grub";
    filesystem.type = "btrfs";
    hardware = {
      cpu = [ "amd" ];
      gpu = [
        "amd"
        "nvidia"
      ];
    };
    networking.domainNameSystem.type = "dnsproxy";
    userland.performanceScaling.type = "asusd";
  };

  boot = {
    kernelParams = [ "processor.max_cstate=1" ];
    loader.efi.canTouchEfiVariables = true;
  };
  hardware = {
    enableRedistributableFirmware = true;
    nvidia = {
      branch = "latest";
      open = true;
      powerManagement.finegrained = true;
      prime = {
        amdgpuBusId = "PCI:6@0:0:0";
        nvidiaBusId = "PCI:1@0:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
  networking.hostName = "vize-strix-scar-g533qr";
  nixpkgs.hostPlatform = "x86_64-linux";
  services.udev.extraRules = ''
    KERNEL=="card*", SUBSYSTEM=="drm", KERNELS=="0000:06:00.0", SUBSYSTEMS=="pci", SYMLINK+="dri/by-type/integrated"
    KERNEL=="card*", SUBSYSTEM=="drm", KERNELS=="0000:01:00.0", SUBSYSTEMS=="pci", SYMLINK+="dri/by-type/discrete"
  '';
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024;
    }
  ];
  system.stateVersion = "26.05";
  zramSwap.enable = true;
}
