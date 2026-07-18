{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      lua-language-server
      nil
      nixd
      nixfmt
      package-version-server

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
      mako
      neovim
      nix-diff
      quickshell
      rofi
      starship
      steam
      wiremix
      wl-clipboard
      yazi
      zed-editor
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Bibata-Modern-Ice";
    };
  };
}
