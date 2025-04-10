{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.totem";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled.xdg.mime.recommended = {
    "audio/*" = ["org.gnome.Totem.desktop"];
    "audio/mpeg" = ["org.gnome.Totem.desktop"];
    "video/*" = ["org.gnome.Totem.desktop"];
  };

  home.ifEnabled.home.packages = [pkgs.totem];
}
