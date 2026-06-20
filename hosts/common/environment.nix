{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      bitwarden-desktop
      (btop.override {
        config = {
          cudaSupport = true;
          rocmSupport = true;
        };
      })
      firefox
      git
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
    };
  };
}
