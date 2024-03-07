{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "services" "mpdris2" {
    enable = enableOption "mpdris2" host.isDesktop;
  }
