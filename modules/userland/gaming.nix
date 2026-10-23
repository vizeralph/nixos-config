{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.kernelModules = [ "ntsync" ];
  environment.systemPackages = [
    pkgs.gamescope
    pkgs.heroic
    pkgs.moonlight
    pkgs.osu-lazer-bin
    pkgs.prismlauncher
  ];
  nixpkgs.config.allowUnfreePackages = [
    "cccl"
    "cuda_crt"
    "cuda_cudart"
    "cuda_nvcc"
    "libnvvm"
    "osu-lazer-bin"
    "steam"
    "steam-unwrapped"
  ];
  programs.steam.enable = true;
  services.sunshine = {
    capSysAdmin = true;
    enable = true;
    openFirewall = true;
    package = pkgs.sunshine.override {
      cudaSupport = lib.elem "nvidia" config.services.xserver.videoDrivers;
    };
  };
  users.users.vize.extraGroups = [ "uinput" ];
}
