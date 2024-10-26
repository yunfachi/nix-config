{delib, ...}:
delib.module {
  name = "programs.nixvim";

  home.ifEnabled.programs.nixvim = {
    #TODO FIXME: base24 colorscheme
    colorschemes.kanagawa = {
      enable = true;
      settings = {
        theme = "dragon";
        background = {
          dark = "dragon";
          light = "lotus";
        };
        # Noice issue
        colors.theme.all.ui.bg_gutter = "none";
      };
    };
  };
}
