{
  boot = {
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
