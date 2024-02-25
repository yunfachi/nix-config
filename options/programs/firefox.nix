{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "firefox" {
    enable = enableOption "firefox" host.isDesktop;
    enableAliases = enableOption "firefox aliases" true;
  }
