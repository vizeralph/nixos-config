{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      lua-language-server
      nixd
      nixfmt

      bibata-cursors
      bitwarden-desktop
      firefox
      gamescope
      git
      keepassxc
      kitty
      mako
      neovim
      rofi
      starship
      steam
      wiremix
      wl-clipboard
      yazi
      zed-editor
      zsh
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Bibata-Modern-Ice";
    };
  };
}
