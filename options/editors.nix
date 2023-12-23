{
  config,
  lib,
  type,
  ...
}: let
  cfg = config.yunfachi;
in {
  options.yunfachi = {
    vscodium.enable = lib.mkEnableOption "vscodium" // {default = type == "desktop";};
    idea.enable = lib.mkEnableOption "idea" // {default = type == "desktop";};
  };
}
