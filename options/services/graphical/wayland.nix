{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "services" "wayland" {
    enable = enableOption "wayland" host.isWayland;
  }
