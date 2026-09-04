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
        localSystem = prev.stdenv.hostPlatform;
        config.allowUnfreePackages = prev.config.allowUnfreePackages or [ ];
        config.permittedInsecurePackages = prev.config.permittedInsecurePackages or [ ];
      };
    })
  ];
  security.sudo.extraConfig = ''Defaults env_keep+="EDITOR VISUAL"'';
  users.users.vize = {
    extraGroups = [ "wheel" ];
    initialPassword = "12345";
    isNormalUser = true;
  };
}
