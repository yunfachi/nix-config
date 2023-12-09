{
  config,
  lib,
  ...
}: let
  cfg = config.yunfachi;
in {
  options.yunfachi = {
    kitty.enable = lib.mkEnableOption "kitty" // {default = true;};
  };
}
