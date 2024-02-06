{
  module-functions,
  hm,
  host,
  ...
}:
module-functions.module "services" "wayland" {
  programs.xwayland.enable = true;
}
