{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "totem" {
    enable = enableOption "totem" host.isDesktop;
  }
