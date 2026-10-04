{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./btop.nix
    ./neovim.nix
    ./performance-scaling.nix
  ];

  environment = {
    systemPackages = [
      pkgs.bat
      pkgs.bitwarden-desktop
      pkgs.brightnessctl
      pkgs.darkman
      pkgs.davinci-resolve
      pkgs.eza
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
      pkgs.material-cursors # TODO: Replace with a simpler/personalized cursor theme.
      pkgs.moonlight
      pkgs.onlyoffice-desktopeditors
      pkgs.osu-lazer
      pkgs.prismlauncher
      pkgs.proton-vpn
      pkgs.qbittorrent
      pkgs.quickshell
      pkgs.starship
      pkgs.wget
      pkgs.wiremix
      pkgs.wl-clipboard
      pkgs.xwayland-satellite
      pkgs.yazi
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      XCURSOR_SIZE = "32";
      XCURSOR_THEME = "material_cursors"; # TODO: Update with the replacement cursor theme.
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
      "osu-lazer"
      "steam"
      "steam-unwrapped"
      "vista-fonts"
    ];
    permittedInsecurePackages = [ ];
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
    sunshine = {
      capSysAdmin = true;
      enable = true;
      openFirewall = true;
    };
    upower.enable = true;
  };
  systemd.user.services = {
    darkman = {
      ##########
      # [Unit] #
      ##########
      description = "Framework for dark-mode and light-mode transitions.";
      documentation = [ "man:darkman(1)" ];

      #############
      # [Service] #
      #############
      serviceConfig = {
        Type = "dbus";
        BusName = "nl.whynothugo.darkman";
        ExecStart = "${pkgs.darkman}/bin/darkman run";
        Restart = "on-failure";
        TimeoutStopSec = 15;
        Slice = "background.slice";
      };

      #############
      # [Install] #
      #############
      wantedBy = [ "default.target" ];
    };
    gammastep = {
      ##########
      # [Unit] #
      ##########
      description = "Display colour temperature adjustment";
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      #############
      # [Service] #
      #############
      serviceConfig = {
        ExecStart = "${pkgs.gammastep}/bin/gammastep";
        Restart = "on-failure";
      };

      #############
      # [Install] #
      #############
      wantedBy = [ "graphical-session.target" ];
    };
  };
  users.users.vize.extraGroups = [ "uinput" ];
  virtualisation.podman = {
    enable = true;
    extraPackages = [ pkgs.podman-compose ];
  };
}
