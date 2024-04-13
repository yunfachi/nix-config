{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "services" "mopidy" {
    enable = enableOption "mopidy" host.isDesktop;
    media_dirs = listOption "media dirs" [] types.str;
  }
