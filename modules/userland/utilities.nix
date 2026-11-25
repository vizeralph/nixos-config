{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.bat
    pkgs.eza
    pkgs.starship
    pkgs.wget
    pkgs.yazi
    pkgs.zoxide
  ];
  programs = {
    git = {
      config = {
        commit.gpgsign = true;
        difftool.prompt = false;
        gpg.format = "ssh";
        merge.tool = "nvimdiff";
      };
      enable = true;
    };
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
