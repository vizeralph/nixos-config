{ config, lib, ... }:
let
  cfg = config.modules.userland.performanceScaling;
in
{
  options.modules.userland.performanceScaling.type = lib.mkOption {
    type = lib.types.enum [
      "asusd"
      "power-profiles-daemon"
      "both"
    ];
    default = "power-profiles-daemon";
  };

  config = lib.mkMerge [
    {
      services = {
        asusd.enable = lib.elem cfg.type [
          "asusd"
          "both"
        ];
        power-profiles-daemon.enable = lib.elem cfg.type [
          "power-profiles-daemon"
          "both"
        ];
      };
    }

    (lib.mkIf (cfg.type == "both") {
      services.asusd.asusdConfig.text = ''
        (
          change_platform_profile_on_ac: false,
          change_platform_profile_on_battery: false,
          platform_profile_linked_epp: false,
        )
      '';
    })
  ];
}
