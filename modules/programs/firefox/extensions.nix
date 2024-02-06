{
  module-functions,
  hm,
  ypkgs,
  username,
  ...
}:
module-functions.module "programs" "firefox" {
  hm.programs.firefox.profiles."${username}".extensions = with ypkgs.firefox-addons; [
    shikiplayer
    coffee_theme_firefox
  ];
}
