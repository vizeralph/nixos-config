{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      mkHost =
        system: hostModule:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ hostModule ];
          specialArgs = { inherit self inputs; };
        };
    in
    {
      nixosConfigurations = {
        vize-strix-scar-15-g533qr = mkHost "x86_64-linux" ./hosts/asus/rog/strix/scar/15/g533qr.nix;
        vize-zephyrus-m16-gu604vi = mkHost "x86_64-linux" ./hosts/asus/rog/zephyrus/m16/gu604vi.nix;
        vize-yoga-7-14irl8 = mkHost "x86_64-linux" ./hosts/lenovo/yoga/7/14irl8.nix;
        vize-portable = mkHost "x86_64-linux" ./hosts/portable.nix;
        vize-wsl = mkHost "x86_64-linux" ./hosts/wsl.nix;
      };
    };
}
