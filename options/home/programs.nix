{
  config,
  lib,
  type,
  ...
}: let
  cfg = config.yunfachi;
in {
  options.yunfachi = {
    firefox.enable = lib.mkEnableOption "firefox" // {default = type == "desktop";};
    kitty.enable = lib.mkEnableOption "kitty" // {default = type == "desktop";};
    shikimori.enable = lib.mkEnableOption "shikimori" // {default = type == "desktop";};
  };
}
