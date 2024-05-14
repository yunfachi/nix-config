{option-functions, ...}:
with option-functions;
  option "services" "jellyfin" {
    enable = enableOption "jellyfin" false;
    openFirewall = enableOption "open ports" true;
  }
