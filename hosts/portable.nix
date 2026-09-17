{ inputs, ... }:

{
  imports = [
    (inputs.self + "/modules")
    (inputs.self + "/modules/bootloader")
    (inputs.self + "/modules/display-manager/ly.nix")
    (inputs.self + "/modules/filesystem/cifs.nix")
    (inputs.self + "/modules/filesystem/ext4.nix")
    (inputs.self + "/modules/hardware/amd.nix")
    (inputs.self + "/modules/hardware/intel.nix")
    (inputs.self + "/modules/hardware/nvidia.nix")
    (inputs.self + "/modules/networking")
  ];

  modules = {
    bootloader.type = "grub";
    hardware = {
      amd = {
        cpu.enable = true;
        gpu.enable = true;
      };
      intel = {
        cpu.enable = true;
        gpu.enable = true;
      };
    };
    networking.domainNameSystem.type = "dnsproxy";
    userland.performanceScaling.type = "both";
  };

  boot.loader.grub.efiInstallAsRemovable = true;
  hardware = {
    enableAllFirmware = true;
    enableAllHardware = true;
    nvidia.open = false;
  };
  networking = {
    hostName = "vize-portable";
    networkmanager.wifi.powersave = true;
  };
  nixpkgs = {
    config.allowUnfreePackages = [
      "b43-firmware"
      "broadcom-bt-firmware"
      "facetimehd-calibration"
      "facetimehd-firmware"
      "nvidia-kernel-modules"
      "xone-dongle-firmware"
    ];
    hostPlatform = "x86_64-linux";
  };
  specialisation.g533q.configuration.boot = {
    kernelParams = [ "processor.max_cstate=1" ];
    loader.grub.configurationName = "2021 ROG Strix SCAR 15";
  };
  system.stateVersion = "26.05";
  zramSwap.enable = true;
}
