{
  module-functions,
  username,
  lib,
  ...
}:
module-functions.module "services" "filebrowser" (cfg: {
  yunfachi.programs.firefox.bookmarks = lib.mkOptionDefault [
    {
      name = "filebrowser";
      url = "http://localhost:5983/";
    }
  ];

  nypkgs.services.filebrowser = {
    enable = true;
    openFirewall = cfg.openFirewall;

    user = username;
  };
})
