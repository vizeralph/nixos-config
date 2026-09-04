{ pkgs, ... }:

{
  environment.systemPackages = [ (pkgs.sddm-astronaut.override { embeddedTheme = "pixel_sakura"; }) ];
  services.displayManager.sddm = {
    enable = true;
    extraPackages = [ pkgs.kdePackages.qtmultimedia ];
    theme = "sddm-astronaut-theme";
    wayland.enable = true;
  };
}
