{
  imports = [
    ./bootloader
    ./filesystem
    ./hardware
    ./networking
    ./userland

    ./display-manager/greetd.nix

    ./core.nix
    ./imaging.nix
    ./locale.nix
  ];
}
