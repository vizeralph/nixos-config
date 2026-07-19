{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      lua-language-server
      nix-diff
      nixd
      nixfmt
      qt6.qtdeclarative
      stylua

      bat
      bibata-cursors
      bitwarden-desktop
      darkman
      eza
      firefox
      gamescope
      gammastep
      git
      keepassxc
      kitty
      neovim
      quickshell
      starship
      steam
      vscode
      wl-clipboard
      yazi
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Bibata-Modern-Ice";
    };
  };
}
