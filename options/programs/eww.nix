{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "eww" {
    enable = enableOption "eww" host.isDesktop;

    config = attrsOption "list of strings, yuck scripts that will be added to config" {} types.str;
  }
