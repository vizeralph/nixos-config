{ inputs, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.bluetooth.enable = true;
  nix = {
    gc = {
      automatic = true;
      dates = "Mon 00:00:00";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = "Fri 00:00:00";
    };
    settings.experimental-features = [
      "flakes"
      "nix-command"
    ];
  };
  nixpkgs.overlays = [
    (_: prev: {
      stable = import inputs.nixpkgs-stable {
        localSystem.system = prev.stdenv.hostPlatform.system;
        config = { inherit (prev.config) allowUnfreePackages permittedInsecurePackages; };
      };
    })
  ];
  security = {
    rtkit.enable = true;
    sudo.extraConfig = ''Defaults env_keep+="EDITOR VISUAL"'';
  };
  users.users.vize = {
    extraGroups = [ "wheel" ];
    initialPassword = "12345";
    isNormalUser = true;
  };
}
