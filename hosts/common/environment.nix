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
