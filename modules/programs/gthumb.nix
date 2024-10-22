{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.gthumb";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.ifEnabled.xdg.mime.associations = {
    "image/*" = ["org.gnome.gThumb.desktop"];
    "image/png" = ["org.gnome.gThumb.desktop"];
    "image/jpeg" = ["org.gnome.gThumb.desktop"];
  };

  home.ifEnabled.home.packages = [pkgs.gthumb];
}
