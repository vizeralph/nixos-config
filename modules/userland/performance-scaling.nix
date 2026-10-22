{
  config,
  lib,
  pkgs,
  ...
}:
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

  config = {
    services = {
      asusd.enable = cfg.type != "power-profiles-daemon";
      power-profiles-daemon.enable = cfg.type != "asusd";
    };
    systemd.services.asusd.serviceConfig.ExecStartPost = lib.mkIf (cfg.type == "both") (
      let
        busctl = "${pkgs.systemd}/bin/busctl --system set-property xyz.ljones.Asusd /xyz/ljones xyz.ljones.Platform";
      in
      map (property: "${busctl} ${property} b false") [
        "ChangePlatformProfileOnAc"
        "ChangePlatformProfileOnBattery"
        "PlatformProfileLinkedEpp"
      ]
    );
  };
}
