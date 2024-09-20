{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.gthumb";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.ifEnabled.xdg.defaultApplications = {
    "image/*" = ["org.gnome.Loupe.desktop"];
  };

  home.ifEnabled.home.packages = [pkgs.gthumb];
}
