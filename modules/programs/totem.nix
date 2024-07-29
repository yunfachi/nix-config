{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "programs" "totem" {
  hm.home.packages = with pkgs; [totem];
}
