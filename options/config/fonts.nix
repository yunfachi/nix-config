{
  option-functions,
  host,
  ...
}:
with option-functions;
  option null "fonts" {
    enable = enableOption "fonts" host.isDesktop;
  }
