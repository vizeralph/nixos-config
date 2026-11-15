{ config, lib, ... }:

{
  imports = [
    ./btrfs.nix
    ./ext4.nix
  ];

  options = {
    modules.filesystem.type = lib.mkOption {
      type = lib.types.enum [
        "btrfs"
        "ext4"
      ];
      default = "ext4";
    };
    swapDevices = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule { config.discardPolicy = lib.mkDefault "both"; });
    };
  };

  config = {
    boot.zswap.enable = lib.mkIf (config.swapDevices != [ ]) (!config.zramSwap.enable);
    fileSystems."/boot" = {
      fsType = "vfat";
      label = "BOOT";
      options = [ "umask=0077" ];
    };
  };
}
