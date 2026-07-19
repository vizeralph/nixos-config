{ inputs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfreePackages = [
        "corefonts"
        "steam"
        "steam-unwrapped"
        "vista-fonts"
        "vscode"
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
