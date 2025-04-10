{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.gthumb";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled.xdg.mime.recommended = {
    "image/*" = ["org.gnome.gThumb.desktop"];
    "image/png" = ["org.gnome.gThumb.desktop"];
    "image/jpeg" = ["org.gnome.gThumb.desktop"];
  };

  home.ifEnabled.home.packages = [pkgs.gthumb];
}
