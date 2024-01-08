{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yunfachi.lunarclient;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [lunar-client];
  };
}
