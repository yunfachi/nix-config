{option-functions, ...}:
with option-functions;
  option "programs" "bat" {
    enable = enableOption "bat" true;
    enableAliases = enableOption "recommended bat aliases (bat, cat)" true;
  }
