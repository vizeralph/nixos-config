{ config, lib, ... }:
let
  cfg = config.modules.bootloader;
in
{
  imports = [
    ./grub.nix
    ./refind.nix
  ];
  options.modules.bootloader.type = lib.mkOption {
    type = lib.types.enum [
      "grub"
      "refind"
      "systemd-boot"
    ];
    default = "systemd-boot";
    description = "Bootloader type.";
  };
  config.boot = {
    consoleLogLevel = 3;
    kernelParams = [ "quiet" ];
    loader = {
      grub.enable = cfg.type == "grub";
      systemd-boot.enable = cfg.type == "systemd-boot";
      timeout = 1;
    };
  };
}
