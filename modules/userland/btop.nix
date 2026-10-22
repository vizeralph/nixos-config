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
    permissions = "u=rx,g=rx,o=";
    owner = "root";
    group = "rapl";
    source = "${btop}/bin/btop";
    capabilities = "cap_perfmon+ep";
  };
}
