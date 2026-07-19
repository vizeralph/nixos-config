{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    corefonts
    nerd-fonts.noto
    vista-fonts
  ];
}
