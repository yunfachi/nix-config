{
  module-functions,
  pkgs,
  hm,
  ...
}:
module-functions.module null "cursor" (cfg: {
  hm.home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    inherit (cfg) name size package;
  };
})
