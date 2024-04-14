{
  module-functions,
  hm,
  ypkgs,
  username,
  ...
}:
module-functions.module "programs" "firefox" {
  hm.programs.firefox.profiles.dev-edition-default.extensions = with ypkgs.firefox-addons; [
    deshiro
    browser-mopidy-youtube
    sepia-coffee-v1
  ];
}
