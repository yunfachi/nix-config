{
  delib,
  host,
  colorscheme,
  ...
}:
delib.module {
  name = "programs.hyprlock";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
        no_fade_in = true;
        ignore_empty_input = true;
      };

      background = {
        monitor = "";
        color = "rgb(${colorscheme.base01.rgb})";
      };

      input-field = {
        monitor = "";
        size = "200, 50";

        outline_thickness = 0;
        dots_rounding = 0;
        rounding = 0;

        fade_on_empty = false;
        placeholder_text = "<span foreground=\"#${colorscheme.base05.hex}\">Password:</span>";
        fail_text = "<span foreground=\"#${colorscheme.base03.hex}\">Wrong</span>";

        inner_color = "rgb(${colorscheme.base03.rgb})";
        font_color = "rgb(${colorscheme.base05.rgb})";
        check_color = "rgb(${colorscheme.base04.rgb})";
        fail_color = "rgb(${colorscheme.base08.rgb})";
      };
    };
  };
}
