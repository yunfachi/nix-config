{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "programs" "osu" {
  hm.home.packages = with pkgs; [osu-lazer-bin];
}
