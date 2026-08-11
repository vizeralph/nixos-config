{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.modules.filesystem.btrfs;
in
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  options.modules.filesystem.btrfs = {
    impermanence.enable = lib.mkEnableOption "Btrfs root rollback and persistent storage management";
    swap = {
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
  };
  config = lib.mkMerge [
    {
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-label/nixos";
          fsType = "btrfs";
          options = [
            "compress=zstd"
            "noatime"
            "subvol=root"
          ];
        };
        "/home" = {
          device = "/dev/disk/by-label/nixos";
          fsType = "btrfs";
          options = [
            "compress=zstd"
            "noatime"
            "subvol=home"
          ];
        };
        "/nix" = {
          device = "/dev/disk/by-label/nixos";
          fsType = "btrfs";
          options = [
            "compress=zstd"
            "noatime"
            "subvol=nix"
          ];
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
    (lib.mkIf cfg.impermanence.enable {
      boot.initrd.postResumeCommands = lib.mkAfter ''
        mkdir -p /btrfs_tmp
        mount -o subvolid=5 /dev/disk/by-label/nixos /btrfs_tmp

        if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
        fi

        delete_subvolume_recursively() {
          IFS=$'\n'

          for subvolume in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$subvolume"
          done

          btrfs subvolume delete "$1"
        }

        for old_root in $(find /btrfs_tmp/old_roots/ -mindepth 1 -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$old_root"
        done

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
      '';
      environment.persistence."/persistent" = {
        directories = [
          "/var/lib/bluetooth"
          "/var/lib/NetworkManager"
          "/var/log"
        ];
        files = [ "/etc/machine-id" ];
        hideMounts = true;
      };
      fileSystems."/persistent" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "btrfs";
        neededForBoot = true;
        options = [
          "compress=zstd"
          "noatime"
          "subvol=persistent"
        ];
      };
    })
    (lib.mkIf (!cfg.impermanence.enable) {
      fileSystems."/var/log" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "btrfs";
        options = [
          "compress=zstd"
          "noatime"
          "subvol=log"
        ];
      };
    })
    (lib.mkIf (cfg.swap.type == "file") {
      fileSystems."/swap" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "btrfs";
        options = [
          "noatime"
          "subvol=swap"
        ];
      };
    })
    (lib.mkIf (cfg.swap.type != "none") {
      boot.zswap.enable = true;
      swapDevices = [
        (
          if cfg.swap.type == "file" then
            {
              device = "/swap/swapfile";
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
