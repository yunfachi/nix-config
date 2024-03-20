{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "wireshark" {
    enable = enableOption "wireshark" host.isDesktop;
  }
