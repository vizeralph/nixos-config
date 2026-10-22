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
  security.wrappers.sunshine =
    lib.mkIf (config.services.sunshine.enable && config.services.sunshine.capSysAdmin)
      {
        group = lib.mkForce "streaming";
        permissions = "u=rx,g=rx,o=";
      };
  services.sunshine = {
    package = pkgs.sunshine.override {
      cudaSupport = lib.elem "nvidia" config.services.xserver.videoDrivers;
    };
    capSysAdmin = true;
    enable = true;
    openFirewall = true;
  };
  users = {
    groups.streaming.members = [ "vize" ];
    users.vize.extraGroups = [ "uinput" ];
  };
}
