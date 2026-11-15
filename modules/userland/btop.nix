{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.modules.hardware) gpu;
  btop = pkgs.btop.override {
    cudaSupport = lib.elem "nvidia" gpu;
    rocmSupport = lib.elem "amd" gpu;
  };
in
{
  environment.systemPackages = [ btop ];
  security.wrappers.btop = lib.mkIf (lib.elem "intel" gpu) {
    permissions = "u=rx,g=rx,o=";
    owner = "root";
    group = "rapl";
    source = "${btop}/bin/btop";
    capabilities = "cap_perfmon+ep";
  };
}
