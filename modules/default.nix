{
  imports = [
    ./bootloader
    ./display-manager/greetd.nix
    ./filesystem
    ./hardware
    ./networking
    ./userland

    ./core.nix
    ./imaging.nix
    ./locale.nix
  ];
}
