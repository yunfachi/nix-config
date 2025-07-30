{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.telegram";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled.persist.user.directories = [".local/share/AyuGramDesktop/tdata"];

  home.ifEnabled.home.packages = [pkgs.ayugram-desktop];
}
