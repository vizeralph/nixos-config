{ self, ... }:

{
  imports = [
    (self + "/hosts/common")

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
