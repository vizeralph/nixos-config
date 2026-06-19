{ lib, ... }:

{
  nixpkgs = {
    config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ ];
    hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
