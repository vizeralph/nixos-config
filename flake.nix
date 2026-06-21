{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    { nixpkgs, nixpkgs-stable, ... }:
    let
      system = "x86_64-linux";
      pkgs-stable = import nixpkgs-stable { inherit system; };
      mkHost =
        modulePath:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ modulePath ];
          specialArgs = { inherit pkgs-stable; };
        };
    in
    {
      nixosConfigurations = {
        # ASUS
        vize-strix-scar-15-g533qr = mkHost ./hosts/asus/rog/strix/scar/15/g533qr;

        # PORTABLE
        vize-t7-shield = mkHost ./hosts/portable/samsung/t7/shield;
      };
    };
}
