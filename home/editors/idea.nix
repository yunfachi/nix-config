{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yunfachi.idea;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.jetbrains; [idea-ultimate];
  };
}
