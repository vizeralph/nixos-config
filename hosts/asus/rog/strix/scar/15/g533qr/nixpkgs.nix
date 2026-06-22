{ lib, ... }:

{
  nixpkgs = {
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "nvidia-settings"
        "nvidia-x11"
        "steam"
        "steam-unwrapped"
        "vscode"
      ];
    hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
