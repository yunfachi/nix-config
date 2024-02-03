{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "services" "sound" {
    enable = enableOption "sound" host.isDesktop;
  }
