{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "services" "openrgb" {
    enable = enableOption "OpenRGB server" host.isDesktop;
  }
