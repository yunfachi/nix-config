{
  config,
  lib,
  pkgs,
  umport,
  ...
}: let
  cfg = config.yunfachi.vscodium;
in {
  imports = umport {path = ./.;};

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };
}
