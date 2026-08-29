{ pkgs, ... }: {
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";
      bigclock = "en";
      brightness_down_cmd = "${pkgs.brightnessctl}/bin/brightnessctl --min-value --quiet set 1%-";
      brightness_up_cmd = "${pkgs.brightnessctl}/bin/brightnessctl --min-value --quiet set +1%";
      clear_password = true;
      default_input = "password";
      hide_key_hints = true;
      hide_version_string = true;
      initial_info_text = "Welcome, VIZE!";
      text_in_center = true;
    };
  };
}
