{
  module-functions,
  hm,
  pkgs,
  lib,
  ...
}:
module-functions.module "programs" "firefox" (cfg: {
  hm.programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-devedition;
    };
    bash.shellAliases = lib.mkIf cfg.enableAliases {
      firefox-devedition = "firefox-devedition -P yunfachi";
      firefox = "firefox-devedition";
    };
  };
})
