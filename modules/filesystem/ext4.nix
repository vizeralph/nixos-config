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
        "file"
        "partition"
        "none"
      ];
      default = "none";
      description = "Swap storage type.";
    };
  };

  config = lib.mkMerge [
    {
      fileSystems = {
        "/" = {
          fsType = "ext4";
          label = "nixos";
          options = [ "noatime" ];
        };
        "/boot" = {
          fsType = "vfat";
          label = "BOOT";
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
          {
            discardPolicy = "both";
          }
          // (
            if cfg.swap.type == "file" then
              {
                device = "/var/lib/swapfile";
                size = cfg.swap.size;
              }
            else
              { label = "swap"; }
          )
        )
      ];
    })
  ];
}
