{
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "usbhid"
      "uas"
      "sd_mod"
    ];
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "processor.max_cstate=1" ];
    zswap.enable = true;
  };
}
