{ self, ... }:

{
  imports = [
    (self + "/hosts/common")

    ./boot.nix
    ./environment.nix
    ./filesystems.nix
    ./hardware.nix
    ./networking.nix
    ./nixpkgs.nix
    ./services.nix
    ./specialisation.nix
    ./zram-swap.nix
  ];
}
