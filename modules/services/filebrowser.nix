{
  module-functions,
  username,
  ...
}:
module-functions.module "services" "filebrowser" (cfg: {
  nypkgs.services.filebrowser = {
    enable = true;
    openFirewall = cfg.openFirewall;

    user = username;
  };
})
