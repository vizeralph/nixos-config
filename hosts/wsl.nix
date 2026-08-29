{ inputs, ... }: {
  imports = [ inputs.nixos-wsl.nixosModules.default ];
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
  programs.nix-ld.enable = true;
  system.stateVersion = "26.05";
  wsl.enable = true;
  
}
