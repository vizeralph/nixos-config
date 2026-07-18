{ inputs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfreePackages = [
        "steam"
        "steam-unwrapped"
      ];
      permittedInsecurePackages = [ "electron-39.8.10" ];
    };
    overlays = [
      (final: prev: {
        stable = import inputs.nixpkgs-stable {
          inherit (prev) system;
          inherit (prev) config;
        };
      })
    ];
  };
}
