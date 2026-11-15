{ lib, ... }:

{
  imports = [
    ./amd.nix
    ./intel.nix
    ./nvidia.nix
  ];

  options.modules.hardware = {
    cpu = lib.mkOption {
      type = lib.types.listOf (
        lib.types.enum [
          "amd"
          "intel"
        ]
      );
      default = [ ];
    };
    gpu = lib.mkOption {
      type = lib.types.listOf (
        lib.types.enum [
          "amd"
          "intel"
          "nvidia"
        ]
      );
      default = [ ];
    };
  };
}
