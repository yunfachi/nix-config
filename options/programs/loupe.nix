{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "loupe" {
    enable = enableOption "loupe" host.isDesktop;
  }
