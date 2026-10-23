{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.modules.filesystem.btrfs;
  mount = subvolume: {
    fsType = "btrfs";
    label = "nixos";
    options = [
      "noatime"
      "compress=zstd"
      "subvol=${subvolume}"
    ];
  };
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
        "/" = mount "root";
        "/games" = mount "games";
        "/home" = mount "home";
        "/nix" = mount "nix";
        "/var/log" = mount "log";
        "/boot" = {
          fsType = "vfat";
          label = "BOOT";
          options = [ "umask=0077" ];
        };
      };
    }

    (lib.mkIf cfg.impermanence.enable {
      boot.initrd.systemd.services.prepare-ephemeral-root = {
        enableStrictShellChecks = true;

        ##########
        # [Unit] #
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
        hideMounts = true;
        directories = [
          "/etc/NetworkManager/system-connections"
          "/etc/asusd"
          "/var/lib/NetworkManager"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd"
          "/var/lib/userborn"
        ];
        files = [
          "/etc/samba/credentials"
          "/etc/machine-id"
        ];
      };
      fileSystems."/persistent" = mount "persistent" // {
        neededForBoot = true;
      };
      services.userborn = {
        enable = true;
        passwordFilesLocation = "/persistent/etc";
      };
    })

    (lib.mkIf (cfg.swap.type != "none") {
      boot.zswap.enable = true;
      fileSystems = lib.optionalAttrs (cfg.swap.type == "file") { "/swap" = mount "swap"; };
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
