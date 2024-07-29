{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "programs" "loupe" {
  hm.home.packages = with pkgs; [loupe];
}
