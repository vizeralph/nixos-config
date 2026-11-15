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

  options.modules.filesystem.btrfs.impermanence.enable = lib.mkEnableOption "impermanence for Btrfs";

  config = lib.mkIf (config.modules.filesystem.type == "btrfs") (
    lib.mkMerge [
      {
        fileSystems = {
          "/" = mount "root";
          "/games" = mount "games";
          "/home" = mount "home";
          "/nix" = mount "nix";
          "/swap" = lib.mkIf (lib.any (swap: lib.hasPrefix "/swap/" swap.device) config.swapDevices) (
            mount "swap"
          );
          "/var/log" = mount "log";
        };
        services.btrfs.autoScrub.enable = true;
      }

      (lib.mkIf cfg.impermanence.enable {
        boot.initrd.systemd.services.prepare-ephemeral-root = {
          enableStrictShellChecks = true;

          unitConfig = {
            Requires = "initrd-root-device.target";
            Before = "sysroot.mount";
            After = [
              "initrd-root-device.target"
              "local-fs-pre.target"
            ];
            DefaultDependencies = false;
          };

          serviceConfig.Type = "oneshot";

          script = ''
            mkdir /btrfs_tmp
            mount /dev/disk/by-label/nixos /btrfs_tmp
            trap 'umount /btrfs_tmp' EXIT

            if [[ -e /btrfs_tmp/root ]]; then
              mkdir -p /btrfs_tmp/old_roots
              timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%d_%H:%M:%S")
              mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
            fi

            for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
              btrfs subvolume delete --recursive "$i"
            done

            btrfs subvolume create /btrfs_tmp/root
          '';

          #############
          # [Install] #
          #############
          requiredBy = [ "sysroot.mount" ];
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
    ]
  );
}
