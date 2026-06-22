{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      bibata-cursors
      bitwarden-desktop
      git
      keepassxc
      kitty
      mako
      neovim
      nixd
      nixfmt
      rofi
      steam
      vscode
      wiremix
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
