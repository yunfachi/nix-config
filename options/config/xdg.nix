{
  option-functions,
  host,
  ...
}:
with option-functions;
  option null "xdg" {
    enable = enableOption "xdg" host.isDesktop;
  }
