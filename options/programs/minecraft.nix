{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "minecraft" {
    enable = enableOption "minecraft" host.isDesktop;
    lunar-client = enableOption "lunar client" host.isDesktop;
  }
