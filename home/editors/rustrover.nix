{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yunfachi.rustrover;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.jetbrains; [rust-rover];
  };
}
