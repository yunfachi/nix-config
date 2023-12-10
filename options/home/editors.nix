{
  config,
  lib,
  ...
}: let
  cfg = config.yunfachi;
in {
  options.yunfachi = {
    vscodium.enable = lib.mkEnableOption "vscodium" // {default = true;};
  };
}
