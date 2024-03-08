{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "ncmpcpp" {
    enable = enableOption "ncmpcpp" host.isDesktop;
  }
