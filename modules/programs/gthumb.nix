{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.gthumb";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled.home.packages = [pkgs.gthumb];
}
