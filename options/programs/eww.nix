{
  option-functions,
  config,
  ...
}:
with option-functions;
  option "programs" "eww" {
    enable = enableOption "eww" true;

    config = attrsOption "list of strings, yuck scripts that will be added to config" {} types.str;
  }
