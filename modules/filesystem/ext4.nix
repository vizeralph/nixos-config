{ config, lib, ... }:

{
  config.fileSystems."/" = lib.mkIf (config.modules.filesystem.type == "ext4") {
    fsType = "ext4";
    label = "nixos";
    options = [ "noatime" ];
  };
}
