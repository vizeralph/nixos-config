{
  nix = {
    gc = {
      automatic = true;
      dates = "Mon *-*-1..7,15..21 00:00:00";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = "Fri *-*-1..7,15..21 00:00:00";
    };
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };
}
