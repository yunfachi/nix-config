{option-functions, ...}:
with option-functions;
  option "services" "bluetooth" {
    enable = enableOption "bluetooth" false;
    enableGui = enableOption "blueman" true;
    enableTui = enableOption "bluetuith" true;
  }
