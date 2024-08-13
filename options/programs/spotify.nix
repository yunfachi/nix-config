{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "spotify" {
    enable = enableOption "spotify" host.isDesktop;
  }
