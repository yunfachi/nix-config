{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.burpsuite";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled.home.packages = [pkgs.burpsuite];
}
