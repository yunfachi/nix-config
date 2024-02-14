{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "starship" {
    enable = enableOption "starship" true;
  }
