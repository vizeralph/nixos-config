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
  options.modules.displayManager.greetd.greeter = lib.mkOption {
    type = lib.types.enum [
      "graphical"
      "terminal"
    ];
    default = "terminal";
  };

  config.services.greetd = {
    enable = true;
    settings.default_session.command =
      if cfg.greeter == "graphical" then
        "${lib.getExe pkgs.cage} -s -- ${lib.getExe pkgs.quickshell} --path ${./greeter.qml}"
      else
        ''
          ${lib.getExe pkgs.tuigreet} \
          --remember-session --remember \
          --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions
        '';
    useTextGreeter = cfg.greeter == "terminal";
  };
}
