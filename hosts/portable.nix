{ self, ... }: {
  imports = [
    (self + "/modules")
    (self + "/modules/bootloader")
    (self + "/modules/networking")
    (self + "/modules/display-manager/ly.nix")
    (self + "/modules/filesystem/ext4.nix")
    (self + "/modules/hardware/amd.nix")
    (self + "/modules/hardware/intel.nix")
    (self + "/modules/hardware/nvidia.nix")
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
  services.asusd.enable = true;
  specialisation.g533q.configuration.boot = {
    kernelParams = [ "processor.max_cstate=1" ];
    loader.grub.configurationName = "2021 ROG Strix SCAR 15";
  };
  system.stateVersion = "26.05";
  zramSwap.enable = true;
}
