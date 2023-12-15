{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yunfachi.discord;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [vesktop];
  };
}
