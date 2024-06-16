{
  module-functions,
  lib,
  pkgs,
  ...
}:
module-functions.module "services" "bluetooth" (cfg: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = cfg.enableGui;
  hm.home.packages = with pkgs; lib.mkIf cfg.enableTui [bluetuith];
})
