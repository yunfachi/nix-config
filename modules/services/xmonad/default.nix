{
  module-functions,
  hm,
  ...
}:
module-functions.module "services" "xmonad" {
  hm.xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;

    config = ./config.hs;
  };
}
