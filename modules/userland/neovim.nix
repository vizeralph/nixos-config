{ lib, pkgs, ... }:
let
  neovim = pkgs.symlinkJoin {
    name = "neovim";
    paths = [ pkgs.neovim ];
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
  };
in
{
  environment.systemPackages = [ neovim ];
}
