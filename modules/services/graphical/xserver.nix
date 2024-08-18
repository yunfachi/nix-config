{
  module-functions,
  host,
  pkgs,
  config,
  ...
}:
module-functions.module "services" "xserver" (cfg: {
  services.displayManager = {
    sessionPackages = [config.hm.wayland.windowManager.hyprland.package];

    sddm = {
      enable = true;
      wayland.enable = host.isWayland;
    };
  };

  services.xserver = {
    enable = true;

    xkb = {
      layout = "us,ru";
      options = "grp:win_space_toggle";
    };
  };
})
