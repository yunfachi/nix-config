{module-functions, ...}:
module-functions.module "services" "wayland" {
  programs.xwayland.enable = true;
}
