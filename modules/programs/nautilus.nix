{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.nautilus";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.ifEnabled.persist.user.directories = [".cache/thumbnails"];

  home.ifEnabled.home.packages = [pkgs.nautilus];
}
