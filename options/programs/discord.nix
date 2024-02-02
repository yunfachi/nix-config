{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "discord" {
    enable = enableOption "discord" host.isDesktop;
  }
