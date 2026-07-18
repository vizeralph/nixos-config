{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (btop.override {
      cudaSupport = true;
      rocmSupport = true;
    })
  ];
}
