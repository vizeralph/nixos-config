{
  config,
  lib,
  pkgs,
  ...
}:
{
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
      pkgs.firefox
      pkgs.gammastep
      pkgs.gimp
      pkgs.git
      pkgs.hyprshot
      pkgs.keepassxc
      pkgs.kitty
      pkgs.krita
      pkgs.libreoffice-fresh
      pkgs.neovim
      pkgs.nixd
      pkgs.nixfmt
      (pkgs.obs-studio.override { cudaSupport = lib.elem "nvidia" config.services.xserver.videoDrivers; })
      pkgs.onlyoffice-desktopeditors
      pkgs.proton-vpn
      pkgs.quickshell
      pkgs.starship
      pkgs.wl-clipboard
      pkgs.yazi
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
  fonts.packages = [
    pkgs.corefonts
    pkgs.nerd-fonts.noto
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
    permittedInsecurePackages = [ "electron-39.8.10" ];
  };
  programs = {
    hyprland.enable = true;
    localsend.enable = true;
    nano.enable = false;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    zsh.enable = true;
  };
  services = {
    flatpak.enable = true;
    pipewire.jack.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
    xserver.excludePackages = [ pkgs.xterm ];
  };
  virtualisation.podman.enable = true;
}
