{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "osu" {
    enable = enableOption "osu" host.isDesktop;
  }
