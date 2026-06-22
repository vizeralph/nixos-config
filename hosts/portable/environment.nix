{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      (btop.override {
        config = {
          cudaSupport = true;
          rocmSupport = true;
        };
      })
    ];
  };
}
