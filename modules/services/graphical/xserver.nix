{
  module-functions,
  host,
  ...
}:
module-functions.module "services" "xserver" (cfg: {
  services = {
    xserver = {
      enable = true;

      xkb = {
        layout = "us,ru";
        options = "grp:win_space_toggle";
      };

      displayManager = {
        gdm = {
          enable = cfg.login-manager == "gdm";
          wayland = host.isWayland;
        };
      };
    };
  };
})
