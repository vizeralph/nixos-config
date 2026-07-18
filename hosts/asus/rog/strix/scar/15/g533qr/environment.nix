{ pkgs, ... }:

{
  environment = {
    # persistence."/persist" = { };
    systemPackages = with pkgs; [
      (btop.override {
        cudaSupport = true;
        rocmSupport = true;
      })
    ];
  };
}
