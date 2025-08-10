{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.heroic";

  options = delib.singleEnableOption (host.guiFeatured && host.gamingFeatured);

  myconfig.ifEnabled.persist.user.directories = [
    ".config/heroic"
    ".local/share/heroic"
  ];

  home.ifEnabled.home.packages = [ pkgs.heroic ];
}
