{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "nautilus" {
    enable = enableOption "nautilus" host.isDesktop;
  }
