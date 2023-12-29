{
  config,
  lib,
  ...
}: let
  cfg = config.yunfachi.steam;
in {
  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
    };
  };
}
