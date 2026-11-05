{ inputs, ... }:

{
  imports = [
    (inputs.self + "/modules")
    (inputs.self + "/modules/filesystem/btrfs.nix")
    (inputs.self + "/modules/filesystem/cifs.nix")
    (inputs.self + "/modules/hardware/intel.nix")
    (inputs.self + "/modules/hardware/nvidia.nix")
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

  boot = {
    kernelParams = [ "mem_sleep_default=s2idle" ];
    loader.efi.canTouchEfiVariables = true;
  };
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
      wants = [ "asusd.service" ];

      #############
      # [Service] #
      #############
      serviceConfig = {
        RestartSec = "5s";
        Restart = "always";
      };
      script = ''
        busctl get-property \
          xyz.ljones.Asusd /xyz/ljones \
          xyz.ljones.Platform PlatformProfile > /dev/null

        IFS= read -r last_profile < /sys/firmware/acpi/platform_profile

        match="type='signal',"
        match+="sender='xyz.ljones.Asusd',"
        match+="path='/xyz/ljones',"
        match+="interface='org.freedesktop.DBus.Properties',"
        match+="member='PropertiesChanged',"
        match+="arg0='xyz.ljones.Platform'"

        busctl --json=short --match="$match" monitor |
        while IFS= read -r _; do
          IFS= read -r current_profile < /sys/firmware/acpi/platform_profile

          if [ "$current_profile" != "$last_profile" ]; then
            systemctl start intel-power-limit.service
            last_profile=$current_profile
          fi
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
      wants = [ "asusd.service" ];

      #############
      # [Service] #
      #############
      serviceConfig.Type = "oneshot";
      script = ''
        zones=(
          /sys/class/powercap/intel-rapl:0
          /sys/class/powercap/intel-rapl-mmio:0
        )

        for zone in "''${zones[@]}"; do
          test "$(cat "$zone/enabled")" = 1
          test "$(cat "$zone/name")" = package-0
          test "$(cat "$zone/constraint_0_name")" = long_term
          test "$(cat "$zone/constraint_0_power_limit_uw")" -gt 0
          test "$(cat "$zone/constraint_1_name")" = short_term
          test "$(cat "$zone/constraint_1_power_limit_uw")" -gt 0
        done

        case "$(cat /sys/firmware/acpi/platform_profile)" in
          performance)  pl1=45; pl2=45 ;;
          balanced)     pl1=35; pl2=45 ;;
          quiet)        pl1=25; pl2=45 ;;
          *)            echo "Unsupported power profile" >&2; exit 1 ;;
        esac

        pl1=$((pl1 * 1000000))
        pl2=$((pl2 * 1000000))

        for zone in "''${zones[@]}"; do
          printf '%s\n' "$pl1" > "$zone/constraint_0_power_limit_uw"
          printf '%s\n' "$pl2" > "$zone/constraint_1_power_limit_uw"
        done
      '';

      #############
      # [Install] #
      #############
      wantedBy = [ "multi-user.target" ];
    };
  };
}
