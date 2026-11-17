{ config, lib, ... }:
let
  cfg = config.modules.filesystem;
in
{
  config.fileSystems."/" = lib.mkIf (cfg.type == "ext4") {
    fsType = "ext4";
    label = "nixos";
    options = [ "noatime" ];
  };
}
