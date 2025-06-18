{
  delib,
  host,
  pkgs,
  colorscheme,
  ...
}:
delib.module {
  name = "cursor";

  options.cursor = with delib; {
    enable = boolOption host.guiFeatured;

    name = strOption "Bibata-Modern-${
      if colorscheme.polarity == "dark"
      then "Ice"
      else "Classic"
    }";
    package = packageOption pkgs.bibata-cursors;
    size = intOption 24;
  };

  home.ifEnabled = {cfg, ...}: {
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      hyprcursor.enable = true;

      inherit (cfg) name package size;
    };
  };
}
