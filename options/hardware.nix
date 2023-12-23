{
  config,
  lib,
  type,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.yunfachi;
in {
  options.yunfachi = {
    type = mkOption {
      type = types.enum ["server" "desktop"];
      default = null;
      example = "desktop";
      description = "Type of host. The default values depend on it.";
    };

    canary.enable = lib.mkEnableOption "canary" // {default = type == "desktop";};
    monitors = mkOption {
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "DP-1";
          };
          width = mkOption {
            type = types.int;
            example = 1920;
          };
          height = mkOption {
            type = types.int;
            example = 1080;
          };
          x = mkOption {
            type = types.int;
            default = 0;
          };
          y = mkOption {
            type = types.int;
            default = 0;
          };
          refreshRate = mkOption {
            type = types.int;
            default = 60;
          };
          scale = mkOption {
            type = types.float;
            default = 1.0;
          };
          primary = mkOption {
            type = types.bool;
            default = false;
          };
        };
      });
      default = [];
    };
  };
}
