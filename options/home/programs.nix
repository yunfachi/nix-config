{
  config,
  lib,
  ...
}: let
  cfg = config.yunfachi;
in {
  options.yunfachi = {
    firefox.enable = lib.mkEnableOption "firefox" // {default = true;};
    kitty.enable = lib.mkEnableOption "kitty" // {default = true;};
  };
}
