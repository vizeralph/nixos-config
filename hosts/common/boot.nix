{ lib, pkgs, ... }:

{
  boot = {
    consoleLogLevel = 3;
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" ];
    loader = {
      grub = {
        device = "nodev";
        efiSupport = true;
        splashImage = null;
        theme = pkgs.fetchFromGitHub {
          owner = "Jacksaur";
          repo = "CRT-Amber-GRUB-Theme";
          rev = "master";
          hash = "sha256-ATm0b9e3Qcv42E5CQYB7Umc8NpWw90QdjJmArOKbmaY=";
        };
      };
      timeout = 1;
    };
  };
}
