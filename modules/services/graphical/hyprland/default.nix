{
  module-functions,
  hm,
  ...
}:
module-functions.module "services" "hyprland" {
  hm.wayland.windowManager.hyprland = {
    enable = true;
  };
}
