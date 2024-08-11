{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "programs" "telegram" {
  hm.home.packages = with pkgs; [kotatogram-desktop];
}
