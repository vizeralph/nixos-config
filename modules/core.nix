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
        localSystem = { inherit (prev.stdenv.hostPlatform) system; };
        config = { inherit (prev.config) allowUnfreePackages permittedInsecurePackages; };
      };
    })
  ];
  security = {
    rtkit.enable = true;
    sudo.extraConfig = ''
      Defaults lecture=never
      Defaults env_keep+="EDITOR VISUAL"
    '';
  };
  systemd.tmpfiles.rules = [ "z /sys/class/powercap/intel-rapl:0/energy_uj 0440 - rapl - -" ];
  users = {
    groups.rapl.members = [ "vize" ];
    users.vize = {
      extraGroups = [ "wheel" ];
      isNormalUser = true;
    };
  };
}
