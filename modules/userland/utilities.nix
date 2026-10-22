{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.bat
    pkgs.eza
    pkgs.git
    pkgs.starship
    pkgs.wget
    pkgs.yazi
    pkgs.zoxide
  ];
  programs = {
    nano.enable = false;
    zsh = {
      enable = true;
      enableGlobalCompInit = false;
    };
  };
  virtualisation.podman = {
    enable = true;
    extraPackages = [ pkgs.podman-compose ];
  };
}
