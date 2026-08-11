{ inputs, pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.bluetooth.enable = true;
  nix = {
    gc = {
      automatic = true;
      dates = "Mon *-*-1..7,15..21 00:00:00";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = "Fri *-*-1..7,15..21 00:00:00";
    };
    settings.experimental-features = [
      "flakes"
      "nix-command"
    ];
  };
  nixpkgs.overlays = [
    (final: prev: {
      stable = import inputs.nixpkgs-stable {
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfreePackages = prev.config.allowUnfreePackages;
        config.permittedInsecurePackages = prev.config.permittedInsecurePackages or [ ];
      };
    })
  ];
  security.sudo.extraConfig = ''Defaults env_keep += "EDITOR VISUAL"'';
  services.xserver.enable = true;
  users.users.vize = {
    extraGroups = [ "wheel" ];
    initialPassword = "12345";
    isNormalUser = true;
  };
}
