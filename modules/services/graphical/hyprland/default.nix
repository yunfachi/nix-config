{
  module-functions,
  hm,
  ypkgs,
  ...
}:
module-functions.module "services" "hyprland" {
  hm.wayland.windowManager.hyprland = {
    enable = true;

    plugins = with ypkgs; [
      split-monitor-workspaces
    ];
  };
}
