{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "kitty" {
    enable = enableOption "kitty" host.isDesktop;
  }
