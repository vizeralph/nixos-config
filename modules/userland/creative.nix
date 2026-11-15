{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.modules.hardware) gpu;
in
{
  environment.systemPackages = [
    (pkgs.blender.override {
      cudaSupport = lib.elem "nvidia" gpu;
      rocmSupport = lib.elem "amd" gpu;
    })
    pkgs.davinci-resolve
    pkgs.gimp
    pkgs.krita
    pkgs.libreoffice
    pkgs.onlyoffice-desktopeditors
  ];
  nixpkgs.config.allowUnfreePackages = [
    "blender"
    "davinci-resolve"
  ];
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override { cudaSupport = lib.elem "nvidia" gpu; };
  };
}
