{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.krita";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.krita];
}
