{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "eza" {
    enable = enableOption "eza" true;
    enableAliases = enableOption "recommended eza aliases (ls, ll…)" true;
    icons = enableOption "icons next to file names" host.isDesktop;
  }
