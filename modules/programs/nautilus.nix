{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "programs" "nautilus" {
  hm.home.packages = with pkgs.gnome; [nautilus];
}
