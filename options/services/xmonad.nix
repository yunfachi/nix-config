{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "services" "xmonad" {
    enable = enableOption "xmonad" (host.window-manager == "xmonad");
  }
