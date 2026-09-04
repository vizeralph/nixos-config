{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./neovim.nix ];

  environment = {
    systemPackages = [
      pkgs.bat
      pkgs.bitwarden-desktop
      pkgs.brightnessctl
      (pkgs.btop.override {
        cudaSupport = lib.elem "nvidia" config.services.xserver.videoDrivers;
        rocmSupport = lib.elem "amdgpu" config.services.xserver.videoDrivers;
      })
      pkgs.darkman
      pkgs.davinci-resolve
      pkgs.eza
      pkgs.faugus-launcher
      pkgs.firefox
      pkgs.gamescope
      pkgs.gammastep
      pkgs.gimp
      pkgs.git
      pkgs.heroic
      pkgs.hyprshot
      pkgs.keepassxc
      pkgs.kitty
      pkgs.krita
      pkgs.libreoffice
      pkgs.material-cursors
      pkgs.moonlight
      pkgs.onlyoffice-desktopeditors
      pkgs.proton-vpn
      pkgs.qbittorrent
      pkgs.quickshell
      pkgs.starship
      pkgs.winboat
      pkgs.wiremix
      pkgs.wl-clipboard
      pkgs.xwayland-satellite
      pkgs.yazi
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      XCURSOR_SIZE = "32";
      XCURSOR_THEME = "material_cursors";
    };
  };
  fonts.packages = [
    pkgs.corefonts
    pkgs.nerd-fonts.noto
    pkgs.noto-fonts
    pkgs.vista-fonts
  ];
  nixpkgs.config = {
    allowUnfreePackages = [
      "corefonts"
      "davinci-resolve"
      "steam"
      "steam-unwrapped"
      "vista-fonts"
    ];
    permittedInsecurePackages = [ "electron-40.10.5" ];
  };
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    localsend.enable = true;
    nano.enable = false;
    niri = {
      enable = true;
      useNautilus = false;
    };
    obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override {
        cudaSupport = lib.elem "nvidia" config.services.xserver.videoDrivers;
      };
      plugins = [ pkgs.obs-studio-plugins.wlrobs ];
    };
    steam.enable = true;
    sway = {
      enable = true;
      extraPackages = [ ];
    };
    zsh.enable = true;
  };
  services = {
    clamav = {
      daemon = {
        enable = true;
        settings = {
          AlertExceedsMax = true;
          MaxFileSize = "1G";
          MaxScanSize = "1G";
        };
      };
      fangfrisch.enable = true;
      updater.enable = true;
    };
    flatpak.enable = true;
    pipewire.jack.enable = true;
    power-profiles-daemon.enable = true;
    sunshine = {
      capSysAdmin = true;
      enable = true;
      openFirewall = true;
    };
    upower.enable = true;
  };
  users.users.vize.extraGroups = [
    "docker"
    "uinput"
  ];
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;
      extraPackages = [ pkgs.podman-compose ];
    };
  };
}
