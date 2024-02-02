{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "steam" {
    enable = enableOption "steam" host.isDesktop;
  }
