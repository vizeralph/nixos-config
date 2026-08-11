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
    rev = "main";
    hash = "sha256-sIxu1Zs/0ZYtt7EQFhzB+AQ6coy1TW+6mCqAV5gM/ic=";
  };
in
{
  config = lib.mkIf (cfg.type == "refind") {
    boot.loader.refind = {
      additionalFiles = {
        "refind-theme/fonts/source-code-pro-extralight-18.png" =
          "${theme}/fonts/source-code-pro-extralight-18.png";
        "refind-theme/icons/os_nixos.png" = "${theme}/icons/os_nixos.png";
        "refind-theme/selection_small.png" = "${theme}/selection_small.png";
      };
      enable = true;
      extraConfig = ''
        font refind-theme/fonts/source-code-pro-extralight-18.png
        icons_dir refind-theme/icons
        selection_small refind-theme/selection_small.png
      '';
    };
  };
}
