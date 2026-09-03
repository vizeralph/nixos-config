{ inputs, pkgs, ... }: {
  imports = [ inputs.nixos-wsl.nixosModules.default ];
  environment.systemPackages = [ pkgs.git ];
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
  programs.nix-ld.enable = true;
  system.stateVersion = "26.05";
  wsl.enable = true;
}
