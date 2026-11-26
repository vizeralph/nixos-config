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
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    nixpkgs-stable.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.zst";
  };

  outputs =
    inputs:
    let
      mkHost =
        hostName: hostModule:
        inputs.nixpkgs.lib.nixosSystem {
          modules = [
            hostModule
            { networking.hostName = hostName; }
          ];
          specialArgs = { inherit inputs; };
        };
    in
    {
      nixosConfigurations = builtins.mapAttrs mkHost {
        vize-helios-neo-phn16-72 = ./hosts/acer/predator-helios-neo/phn16-72.nix;
        vize-strix-scar-g533qr = ./hosts/asus/rog-strix-scar/g533qr.nix;
        vize-zephyrus-m16-gu604vi = ./hosts/asus/rog-zephyrus-m16/gu604vi.nix;
        vize-yoga-7-14irl8 = ./hosts/lenovo/yoga-7/14irl8.nix;
        vize-portable = ./hosts/portable.nix;
        vize-vm = ./hosts/vm.nix;
        vize-wsl = ./hosts/wsl.nix;
      };
    };
}
