{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.displayManager.greetd;
in
{
  options.modules.displayManager.greetd.type = lib.mkOption {
    type = lib.types.enum [
      "graphical"
      "terminal"
    ];
    default = "terminal";
  };

  config.services.greetd = {
    enable = true;
    settings.default_session.command =
      if cfg.type == "graphical" then
        # TODO
        "${lib.getExe pkgs.cage} -s -- ${lib.getExe pkgs.quickshell} --path ${./greeter.qml}"
      else
        "${lib.getExe pkgs.tuigreet} --remember-session --remember --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --session-wrapper '${pkgs.systemd}/bin/systemd-cat --identifier=wayland-session'";
    useTextGreeter = cfg.type == "terminal";
  };
}
