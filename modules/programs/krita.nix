{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.krita";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled.home.packages = [pkgs.krita];
}
