{
  module-functions,
  hm,
  pkgs,
  ypkgs,
  username,
  ...
}:
module-functions.module "programs" "firefox" {
  hm.programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };
}
