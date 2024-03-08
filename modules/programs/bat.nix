{
  module-functions,
  hm,
  lib,
  ...
}:
module-functions.module "programs" "eza" (cfg: {
  hm.programs = {
    bat = {
      enable = true;
    };
    bash.shellAliases = {
      bat = "bat --style='numbers,grid'";
      cat = lib.mkIf cfg.enableAliases "bat";
    };
  };
})
