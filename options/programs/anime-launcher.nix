{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "anime-launcher" {
    enable = enableOption "anime-launcher" host.isDesktop;
  }
