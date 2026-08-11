{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.bootloader;
in
{
  config = lib.mkIf (cfg.type == "limine") {
    boot.loader.limine = {
      enable = true;
      style = {
        wallpapers = [
          (pkgs.fetchurl {
            url = "https://w.wallhaven.cc/full/k8/wallhaven-k81776.jpg";
            hash = "sha256-1EkUMn4kFtzMIu3+36938CHG1MtcUMqEYH2d/Hp1w0U=";
          })
        ];
        wallpaperStyle = "stretched";
      };
    };
  };
}
