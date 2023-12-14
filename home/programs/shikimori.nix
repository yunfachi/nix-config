{
  config,
  lib,
  pkgs-yunfachi,
  ...
}: let
  cfg = config.yunfachi.shikimori;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs-yunfachi; [shikimori];
  };
}
