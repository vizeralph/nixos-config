{ config, lib, ... }:
let
  cfg = config.modules.filesystem.ext4;
in
{
  options.modules.filesystem.ext4.swap = {
    size = lib.mkOption {
      type = lib.types.ints.positive;
      default = 8 * 1024;
    };
    type = lib.mkOption {
      type = lib.types.enum [
        "file"
        "partition"
        "none"
      ];
      default = "none";
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
                inherit (cfg.swap) size;
              }
            else
              { label = "swap"; }
          )
        )
      ];
    })
  ];
}
