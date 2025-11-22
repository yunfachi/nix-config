{
  delib,
  host,
  colorscheme,
  lib,
  ...
}:
delib.module {
  name = "qt";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.qt = {
    enable = true;
    platformTheme.name = "gnome";
    style.name = "adwaita${lib.optionalString (colorscheme.polarity == "dark") "-dark"}";
  };
}
