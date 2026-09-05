{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.bootloader;
  theme = pkgs.fetchFromGitHub {
    owner = "phamhuulocforwork";
    repo = "refind-theme";
    rev = "f408d51d54b4c8de5628d14b8d095752dbd89e92";
    hash = "sha256-sIxu1Zs/0ZYtt7EQFhzB+AQ6coy1TW+6mCqAV5gM/ic=";
  };
in
{
  config = lib.mkIf (cfg.type == "refind") {
    boot.loader.refind = {
      additionalFiles = {
        "refind-theme/fonts/source-code-pro-extralight-18.png" =
          "${theme}/fonts/source-code-pro-extralight-18.png";
        "refind-theme/icons/os_linux.png" = "${theme}/icons/os_nixos.png";
        "refind-theme/icons/os_win.png" = "${theme}/icons/os_win.png";
        "refind-theme/background.png" = "${theme}/background.png";
        "refind-theme/selection_big.png" = "${theme}/selection_big.png";
        "refind-theme/selection_small.png" = "${theme}/selection_small.png";
      };
      enable = true;
      extraConfig = ''
        hideui badges,hints,label
        icons_dir refind-theme/icons
        banner refind-theme/background.png
        banner_scale fillscreen
        selection_big refind-theme/selection_big.png
        selection_small refind-theme/selection_small.png
        font refind-theme/fonts/source-code-pro-extralight-18.png
        use_graphics_for linux
        showtools
      '';
    };
  };
}
