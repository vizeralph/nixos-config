{ config, lib, ... }:
let
  cfg = config.modules.filesystem.ext4;
in
{
  options.modules.filesystem.ext4.swap = {
    size = lib.mkOption {
      type = lib.types.int;
      default = 8 * 1024;
      description = "Swapfile size in megabytes.";
    };
    type = lib.mkOption {
      type = lib.types.enum [
        "none"
        "file"
        "partition"
      ];
      default = "none";
      description = "Swap storage type.";
    };
  };
  config = lib.mkMerge [
    {
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-label/nixos";
          fsType = "ext4";
          options = [ "noatime" ];
        };
        "/boot" = {
          device = "/dev/disk/by-label/BOOT";
          fsType = "vfat";
          options = [
            "dmask=0077"
            "fmask=0077"
          ];
        };
      };
    }
    (lib.mkIf (cfg.swap.type != "none") {
      boot.zswap.enable = true;
      swapDevices = [
        (
          if cfg.swap.type == "file" then
            {
              device = "/var/lib/swapfile";
              discardPolicy = "both";
              size = cfg.swap.size;
            }
          else
            {
              discardPolicy = "both";
              label = "swap";
            }
        )
      ];
    })
  ];
}
