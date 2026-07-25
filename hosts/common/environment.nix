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

      aichat
      bat
      bitwarden-desktop
      darkman
      eza
      firefox
      gamescope
      gammastep
      git
      hyprshot
      keepassxc
      kitty
      libreoffice-fresh
      neovim
      obs-studio
      opencode
      phinger-cursors
      podman
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
    };
  };
}
