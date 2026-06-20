{
  boot = {
    # initrd.availableKernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "processor.max_cstate=1" ];
  };
}
