{
  module-functions,
  hm,
  pkgs,
  username,
  ...
}:
module-functions.module "programs" "firefox" {
  hm.programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;

    profiles."${username}" = {
      extensions = [
      ];
    };
  };
}
