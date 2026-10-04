{
  config,
  lib,
  pkgs,
  ...
}:
let
  btop = pkgs.btop.override {
    cudaSupport = lib.elem "nvidia" config.services.xserver.videoDrivers;
    rocmSupport = lib.elem "amdgpu" config.services.xserver.videoDrivers;
  };
in
{
  environment.systemPackages = [ btop ];
  security.wrappers.btop = lib.mkIf (config.modules.hardware.intel.gpu.enable or false) {
    source = "${btop}/bin/btop";
    owner = "root";
    group = "root";
    capabilities = "cap_perfmon+ep";
  };
}
