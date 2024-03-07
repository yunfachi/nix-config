{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "services" "mopidy" {
    enable = enableOption "mopidy" host.isDesktop;
  }
