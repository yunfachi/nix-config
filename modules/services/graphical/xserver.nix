{
  module-functions,
  hm,
  host,
  username,
  lib,
  ...
}:
module-functions.module "services" "xserver" (cfg: {
  services = {
    xserver = {
      enable = true;

      layout = "us,ru";
      xkbOptions = "grp:win_space_toggle";

      displayManager = {
        gdm = {
          enable = cfg.login-manager == "gdm";
          wayland = host.isWayland;
        };
      };
    };
  };
})
