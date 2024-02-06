{
  module-functions,
  hm,
  ...
}:
module-functions.module "services" "awesome" {
  hm.xsession.windowManager.awesome = {
    enable = true;

    luaModules = [];
  };
}
