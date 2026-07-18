{ self, inputs, ... }:

{
  imports = [
    (self + "/hosts/common")

    inputs.impermanence.nixosModules.impermanence

    ./boot.nix
    ./environment.nix
    ./filesystem.nix
    ./hardware.nix
    ./networking.nix
    ./nixpkgs.nix
    ./services.nix
    ./swap-devices.nix
  ];
}
