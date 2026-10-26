{ pkgs, ... }:
{
  environment = {
    systemPackages = [
      pkgs.bibata-cursors
      pkgs.brightnessctl
      pkgs.darkman
      pkgs.firefox
      pkgs.gammastep
      pkgs.grim
      pkgs.jq
      pkgs.kitty
      pkgs.matugen
      pkgs.qbittorrent
      pkgs.quickshell
      pkgs.slurp
      pkgs.wiremix
      pkgs.wl-clipboard
    ];
    variables = {
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Bibata-Modern-Ice";
    };
  };
  fonts.packages = [
    pkgs.corefonts
    pkgs.nerd-fonts.noto
    pkgs.noto-fonts
    pkgs.vista-fonts
  ];
  nixpkgs.config.allowUnfreePackages = [
    "corefonts"
    "vista-fonts"
  ];
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    localsend.enable = true;
    mango.enable = true;
  };
  services = {
    flatpak.enable = true;
    pipewire.jack.enable = true;
    upower.enable = true;
  };
  systemd = {
    packages = [
      pkgs.darkman
      pkgs.gammastep
    ];
    user.services = {
      darkman = {
        path = [
          pkgs.bash
          pkgs.dconf
        ];
        wantedBy = [ "default.target" ];
      };
      gammastep.wantedBy = [ "graphical-session.target" ];
    };
  };
}
