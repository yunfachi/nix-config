{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "programs" "alejandra" {
  hm.home.packages = with pkgs; [alejandra];
}
