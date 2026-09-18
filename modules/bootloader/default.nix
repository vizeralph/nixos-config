{ config, lib, ... }:
let
  cfg = config.modules.bootloader;
in
{
  imports = [
    ./grub.nix
    ./refind.nix
  ];

  options.modules.bootloader = {
    verbose = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    type = lib.mkOption {
      type = lib.types.enum [
        "grub"
        "refind"
        "systemd-boot"
      ];
      default = "systemd-boot";
    };
  };

  config.boot = {
    consoleLogLevel = if cfg.verbose then 7 else 3;
    kernelParams = lib.optionals (!cfg.verbose) [ "quiet" ];
    loader = {
      grub.enable = cfg.type == "grub";
      systemd-boot.enable = cfg.type == "systemd-boot";
      timeout = 1;
    };
  };
}
