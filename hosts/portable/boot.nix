{
  boot = {
    extraModprobeConfig = "options nvidia NVreg_EnableS0ixPowerManagement=1";
    kernelModules = [
      "kvm-amd"
      "kvm-intel"
    ];
    loader.grub = {
      default = "saved";
      efiInstallAsRemovable = true;
    };
  };
}
