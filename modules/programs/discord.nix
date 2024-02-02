{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "programs" "discord" {
  hm.home.packages = with pkgs; [
    vesktop
  ];
}
