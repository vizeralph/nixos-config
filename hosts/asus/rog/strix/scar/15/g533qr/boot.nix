{
  boot = {
    extraModprobeConfig = "options nvidia NVreg_EnableS0ixPowerManagement=1";
    initrd.availableKernelModules = [
      "nvme"
      "sd_mod"
      "uas"
      "usbhid"
      "xhci_pci"
    ];
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "processor.max_cstate=1" ];
    zswap.enable = true;
  };
}
