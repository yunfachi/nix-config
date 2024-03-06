{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "programs" "minecraft" (cfg: {
  hm.home.packages = with pkgs;
  with lib;
    optionals cfg.lunar-client [lunar-client];
})
