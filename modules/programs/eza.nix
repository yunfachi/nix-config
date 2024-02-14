{
  module-functions,
  hm,
  lib,
  ...
}:
module-functions.module "programs" "eza" (cfg: {
  hm.programs = {
    eza = {
      enable = true;

      enableAliases = cfg.enableAliases;
      git = true;
      icons = cfg.icons;

      extraOptions = [
        "--hyperlink"
        "--no-permissions"
        "--no-user"
        "--no-time"
      ];
    };
    bash.shellAliases = lib.mkIf cfg.enableAliases {
      tree = "eza --tree";
    };
  };
})
