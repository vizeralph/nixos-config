{
  home-manager.users.vize = {
    imports = [
      ./home.nix
      ./programs.nix
    ];
  };
}
