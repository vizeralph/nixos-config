{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    (pkgs.blender.override {
      cudaSupport = lib.elem "nvidia" config.services.xserver.videoDrivers;
      rocmSupport = lib.elem "amdgpu" config.services.xserver.videoDrivers;
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
    package = pkgs.obs-studio.override {
      cudaSupport = lib.elem "nvidia" config.services.xserver.videoDrivers;
    };
  };
}
