{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "codium" {
    enable = enableOption "codium" host.isDesktop;
  }
