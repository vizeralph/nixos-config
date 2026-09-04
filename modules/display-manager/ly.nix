{ pkgs, ... }:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";
      animation_frame_delay = 3;
      asterisk = "0x2022";
      auth_fails = 5;
      bigclock = "en";
      brightness_down_cmd = "${pkgs.brightnessctl}/bin/brightnessctl --min-value --quiet set 1%-";
      brightness_up_cmd = "${pkgs.brightnessctl}/bin/brightnessctl --min-value --quiet set +1%";
      clear_password = true;
      colormix_col1 = "0x00E6E6E6";
      colormix_col2 = "0x00999999";
      colormix_col3 = "0x004D4D4D";
      default_input = "password";
      hide_key_hints = true;
      hide_version_string = true;
      initial_info_text = "Welcome, VIZE!";
      text_in_center = true;
    };
  };
}
