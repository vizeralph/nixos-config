{
  boot = {
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ "processor.max_cstate=1" ];
  };
}
