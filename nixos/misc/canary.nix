{
  config,
  lib,
  pkgs-yunfachi,
  ...
}: let
  cfg = config.hm.yunfachi.canary;
in {
  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      xkb = {
        extraLayouts.canary = {
          symbolsFile = pkgs-yunfachi.canary + "/share/X11/xkb/symbols/canary";
          description = "Canary keyboard layout";
          languages = ["eng"];
        };
        layout = "canary,ru";
      };
    };
    console.useXkbConfig = true;
  };
}
