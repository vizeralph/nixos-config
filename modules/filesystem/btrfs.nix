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
    impermanence.enable = lib.mkEnableOption "impermanence for Btrfs";
    swap = {
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
      boot.initrd.systemd.services.recreate-root = {
        ##########
        # [UNIT] #
        ##########
        requires = [ "initrd-root-device.target" ];
        before = [ "sysroot.mount" ];
        after = [
          "initrd-root-device.target"
          "local-fs-pre.target"
        ];
        unitConfig.DefaultDependencies = false;

        #############
        # [Service] #
        #############
        serviceConfig.Type = "oneshot";
        script = ''
          mountpoint=/btrfs_tmp
          root="$mountpoint/root"
          old_roots="$mountpoint/old_roots"

          mkdir --parents "$mountpoint"
          mount --types btrfs --options subvolid=5 ${
            lib.escapeShellArg config.fileSystems."/".device
          } "$mountpoint"

          trap 'umount "$mountpoint"' EXIT

          if [[ -e "$root" ]]; then
              mkdir --parents "$old_roots"
              timestamp=$(date --date="@$(stat --format=%Y "$root")" "+%Y-%m-%d_%H:%M:%S")
              mv "$root" "$old_roots/$timestamp"
          fi

          if [[ -d "$old_roots" ]]; then
              cutoff=$(( $(date +%s) - 30 * 24 * 60 * 60 ))

              for old_root in "$old_roots"/*; do
                  [[ -e "$old_root" ]] || continue

                  if (( $(stat --format=%Y "$old_root") < cutoff )); then
                      btrfs subvolume delete --recursive "$old_root"
                  fi
              done
          fi

          btrfs subvolume create "$root"
        '';

        #############
        # [Install] #
        #############
        requiredBy = [ "initrd.target" ];
      };
      environment.persistence."/persistent" = {
        directories = [
          "/etc/NetworkManager/system-connections"
          "/var/lib/NetworkManager"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
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
                inherit (cfg.swap) size;
              }
          )
        )
      ];
    })
  ];
}
