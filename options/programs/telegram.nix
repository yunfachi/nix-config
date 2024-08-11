{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "telegram" {
    enable = enableOption "telegram" host.isDesktop;
  }
