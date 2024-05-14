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
      package = pkgs.firefox-devedition-bin;
    };

    bash.shellAliases = lib.mkIf cfg.enableAliases {
      firefox = "firefox-developer-edition";
    };
  };
})
