{ config, lib, ... }:
let
  cfg = config.modules.bootloader;
in
{
  imports = [
    ./grub.nix
    ./limine.nix
    ./refind.nix
  ];
  options.modules.bootloader.type = lib.mkOption {
    type = lib.types.enum [
      "grub"
      "limine"
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
