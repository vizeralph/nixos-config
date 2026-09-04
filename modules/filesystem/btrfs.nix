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
          "file"
          "partition"
          "none"
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
          fsType = "btrfs";
          label = "nixos";
          options = [
            "compress=zstd"
            "noatime"
            "subvol=root"
          ];
        };
        "/games" = {
          fsType = "btrfs";
          label = "nixos";
          options = [
            "compress=zstd"
            "noatime"
            "subvol=games"
          ];
        };
        "/home" = {
          fsType = "btrfs";
          label = "nixos";
          options = [
            "compress=zstd"
            "noatime"
            "subvol=home"
          ];
        };
        "/nix" = {
          fsType = "btrfs";
          label = "nixos";
          options = [
            "compress=zstd"
            "noatime"
            "subvol=nix"
          ];
        };
        "/var/log" = {
          fsType = "btrfs";
          label = "nixos";
          options = [
            "compress=zstd"
            "noatime"
            "subvol=log"
          ];
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
    (lib.mkIf cfg.impermanence.enable {
      boot.initrd.postResumeCommands = lib.mkAfter ''
        mkdir /btrfs_tmp
        mount /dev/disk/by-label/nixos /btrfs_tmp

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

        for old_root in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
            delete_subvolume_recursively "$old_root"
        done

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
      '';
      environment.persistence."/persistent" = {
        directories = [
          "/etc/NetworkManager/system-connections"
          "/var/lib/NetworkManager"
          "/var/lib/bluetooth"
        ];
        files = [ "/etc/machine-id" ];
        hideMounts = true;
      };
      fileSystems."/persistent" = {
        fsType = "btrfs";
        label = "nixos";
        neededForBoot = true;
        options = [
          "compress=zstd"
          "noatime"
          "subvol=persistent"
        ];
      };
    })
    (lib.mkIf (cfg.swap.type == "file") {
      fileSystems."/swap" = {
        fsType = "btrfs";
        label = "nixos";
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
          {
            discardPolicy = "both";
          }
          // (
            if cfg.swap.type == "partition" then
              { label = "swap"; }
            else
              {
                device = "/swap/swapfile";
                size = cfg.swap.size;
              }
          )
        )
      ];
    })
  ];
}
