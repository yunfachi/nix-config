{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.steam";

  options = delib.singleEnableOption (host.guiFeatured && host.gamingFeatured);

  myconfig.ifEnabled.persist.user.directories = [".steam" ".local/share/Steam"];

  home.ifEnabled.home.packages = [pkgs.steam];
}
