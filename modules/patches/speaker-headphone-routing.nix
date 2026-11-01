{ config, pkgs, ... }:

{
  environment.etc."alsa-card-profile/paths/analog-output-speaker.conf".source = pkgs.substitute {
    src = "${config.services.pipewire.package}/share/alsa-card-profile/mixer/paths/analog-output-speaker.conf";
    substitutions = [
      "--replace-fail"
      ''
        [Jack Headphone]
        state.plugged = no
        state.unplugged = unknown
      ''
      ''
        [Jack Headphone]
        state.plugged = unknown
        state.unplugged = unknown
      ''
    ];
  };
}
