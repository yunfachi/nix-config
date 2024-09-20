{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.totem";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.ifEnabled.xdg.defaultApplications = {
    "audio/*" = ["org.gnome.Totem.desktop"];
    "audio/mpeg" = ["org.gnome.Totem.desktop"];
    "video/*" = ["org.gnome.Totem.desktop"];
  };

  home.ifEnabled.home.packages = [pkgs.totem];
}
