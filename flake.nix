{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs-stable = import nixpkgs-stable { inherit system; };
      mkHost =
        hostModule:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ hostModule ];
          specialArgs = { inherit self pkgs-stable; };
        };
    in
    {
      nixosConfigurations = {
        # ASUS
        vize-strix-scar-15-g533qr = mkHost ./hosts/asus/rog/strix/scar/15/g533qr;

        # PORTABLE
        vize-portable = mkHost ./hosts/portable;
      };
    };
}
