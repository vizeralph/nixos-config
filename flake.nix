{
  inputs = {
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
  };
  outputs =
    inputs:
    let
      mkHost =
        hostModule:
        inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ hostModule ];
          specialArgs = { inherit inputs; };
        };
    in
    {
      nixosConfigurations = {
        vize-strix-scar-15-g533qr = mkHost ./hosts/asus/rog/strix/scar/15/g533qr.nix;
        vize-zephyrus-m16-gu604vi = mkHost ./hosts/asus/rog/zephyrus/m16/gu604vi.nix;
        vize-yoga-7-14irl8 = mkHost ./hosts/lenovo/yoga/7/14irl8.nix;
        vize-portable = mkHost ./hosts/portable.nix;
        vize-wsl = mkHost ./hosts/wsl.nix;
      };
    };
}
