{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.bootloader;
in
{
  config = lib.mkIf (cfg.type == "grub") {
    boot.loader.grub = {
      default = "saved";
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
  };
}
