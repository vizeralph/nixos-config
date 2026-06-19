{ lib, pkgs, ... }:

{
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernelParams = [
      "loglevel=3"
      "quiet"
    ];
    loader = {
      grub = {
        device = "nodev";
        efiSupport = true;
        theme = pkgs.fetchFromGitHub {
          hash = "sha256-ATm0b9e3Qcv42E5CQYB7Umc8NpWw90QdjJmArOKbmaY=";
          owner = "Jacksaur";
          repo = "CRT-Amber-GRUB-Theme";
          rev = "master";
        };
      };
      timeout = 1;
    };
  };
}
