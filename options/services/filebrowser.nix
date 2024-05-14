{option-functions, ...}:
with option-functions;
  option "services" "filebrowser" {
    enable = enableOption "filebrowser" false;
    openFirewall = enableOption "open ports" true;
  }
