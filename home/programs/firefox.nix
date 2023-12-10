{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yunfachi.firefox;
in {
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-devedition;
    };
  };
}
