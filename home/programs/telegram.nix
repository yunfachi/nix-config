{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yunfachi.telegram;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [telegram-desktop];
  };
}
