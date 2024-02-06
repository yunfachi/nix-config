{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "services" "x11" {
    enable = enableOption "x11" host.isX11;
  }
