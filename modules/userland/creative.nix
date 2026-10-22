{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.davinci-resolve
    pkgs.gimp
    pkgs.krita
    pkgs.libreoffice
    pkgs.onlyoffice-desktopeditors
  ];
  nixpkgs.config.allowUnfreePackages = [ "davinci-resolve" ];
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      cudaSupport = lib.elem "nvidia" config.services.xserver.videoDrivers;
    };
    plugins = [ pkgs.obs-studio-plugins.wlrobs ];
  };
}
