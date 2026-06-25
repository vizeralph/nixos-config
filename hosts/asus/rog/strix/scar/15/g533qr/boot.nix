{
  boot = {
    extraModprobeConfig = "options nvidia NVreg_EnableS0ixPowerManagement=1";
    initrd.availableKernelModules = [
      "nvme"
      "usbhid"
      "xhci_pci"
    ];
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "processor.max_cstate=1" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub.useOSProber = true;
    };
    zswap.enable = true;
  };
}
