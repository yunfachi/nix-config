{
  delib,
  pkgs,
  host,
  colorscheme,
  lib,
  ...
}:
delib.module {
  name = "gtk";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled.gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3${lib.optionalString (colorscheme.polarity == "dark") "-dark"}";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
