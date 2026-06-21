{ pkgs, ... }:

{
  services = {
    displayManager.ly = {
      enable = true;
      settings = {
        animation = "colormix";
        bigclock = "en";
        brightness_down_cmd = "${pkgs.brightnessctl}/bin/brightnessctl --min-value --quiet set 5%-";
        brightness_up_cmd = "${pkgs.brightnessctl}/bin/brightnessctl --min-value --quiet set +5%";
        clear_password = true;
        default_input = "password";
        hide_key_hints = true;
        hide_version_string = true;
        initial_info_text = "Welcome, VIZE!";
      };
    };
    dnsproxy = {
      enable = true;
      settings = {
        bootstrap = [
          "94.140.14.14:53"
          "94.140.15.15:53"
          "[2a10:50c0::ad1:ff]:53"
          "[2a10:50c0::ad2:ff]:53"
        ];
        cache = true;
        fallback = [ "https://dns.adguard-dns.com/dns-query" ];
        listen-addrs = [
          "127.0.0.1"
          "::1"
        ];
        ratelimit-subnet-len-ipv6 = 64;
        upstream = [ "quic://dns.adguard-dns.com" ];
      };
    };
    pipewire = {
      alsa = {
        enable = true;
        support32Bit = true;
      };
      enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    power-profiles-daemon.enable = true;
  };
}
