{ lib, pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.symlinkJoin {
      name = "neovim";
      paths = [ pkgs.neovim-unwrapped ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/nvim --prefix PATH : ${
          lib.makeBinPath [
            pkgs.fd
            pkgs.gcc
            pkgs.nixd
            pkgs.nixfmt
            pkgs.ripgrep
          ]
        }
      '';
    })
  ];
}
