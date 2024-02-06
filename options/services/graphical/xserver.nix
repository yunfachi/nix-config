{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "services" "xserver" {
    enable = enableOption "xserver" host.isDesktop;
    login-manager = enumOption "login-manager" "gdm" ["gdm"];
  }
