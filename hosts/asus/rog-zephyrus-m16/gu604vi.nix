{ inputs, ... }:

{
  imports = [
    (inputs.self + "/modules")
    (inputs.self + "/modules/bootloader")
    (inputs.self + "/modules/display-manager/ly.nix")
    (inputs.self + "/modules/filesystem/btrfs.nix")
    (inputs.self + "/modules/filesystem/cifs.nix")
    (inputs.self + "/modules/hardware/intel.nix")
    (inputs.self + "/modules/hardware/nvidia.nix")
    (inputs.self + "/modules/networking")
    (inputs.self + "/modules/patches/speaker-headphone-routing.nix")
  ];

  modules = {
    bootloader.type = "grub";
    filesystem.btrfs.swap = {
      size = 32 * 1024;
      type = "file";
    };
    hardware.intel = {
      cpu.enable = true;
      gpu.enable = true;
    };
    networking.domainNameSystem.type = "dnsproxy";
    userland.performanceScaling.type = "asusd";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  hardware = {
    enableRedistributableFirmware = true;
    nvidia = {
      branch = "latest";
      open = true;
      powerManagement.finegrained = true;
      prime = {
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
  networking.hostName = "vize-zephyrus-m16-gu604vi";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";
  systemd.services = {
    asus-profile-watch = {
      enableStrictShellChecks = true;

      ##########
      # [Unit] #
      ##########
      after = [ "asusd.service" ];

      #############
      # [Service] #
      #############
      serviceConfig.Restart = "always";
      script = ''
        match="type='signal',"
        match+="sender='xyz.ljones.Asusd',"
        match+="path='/xyz/ljones',"
        match+="interface='org.freedesktop.DBus.Properties',"
        match+="member='PropertiesChanged',"
        match+="arg0='xyz.ljones.Platform'"

        busctl --system --json=short --match="$match" monitor |
        while IFS= read -r _; do
          systemctl start intel-power-limit.service
        done
      '';

      #############
      # [Install] #
      #############
      wantedBy = [ "multi-user.target" ];
    };
    intel-power-limit = {
      enableStrictShellChecks = true;

      ##########
      # [Unit] #
      ##########
      after = [ "asusd.service" ];

      #############
      # [Service] #
      #############
      serviceConfig.Type = "oneshot";
      script = ''
        zone=/sys/class/powercap/intel-rapl/intel-rapl:0

        case "$(cat /sys/firmware/acpi/platform_profile)" in
          performance) pl1=45000000 ;;
          balanced)    pl1=35000000 ;;
          quiet)       pl1=25000000 ;;
          *) echo "Unsupported power profile" >&2; exit 1 ;;
        esac

        test "$(cat "$zone/name")" = package-0
        test "$(cat "$zone/constraint_0_name")" = long_term
        test "$(cat "$zone/constraint_1_name")" = short_term

        printf '%s\n' "$pl1" > "$zone/constraint_0_power_limit_uw"
        printf '%s\n' 45000000 > "$zone/constraint_1_power_limit_uw"

        test "$(cat "$zone/constraint_0_power_limit_uw")" = "$pl1"
        test "$(cat "$zone/constraint_1_power_limit_uw")" = 45000000
      '';

      #############
      # [Install] #
      #############
      wantedBy = [ "multi-user.target" ];
    };
  };
}
