{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.totem";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled.home.packages = [pkgs.totem];
}
