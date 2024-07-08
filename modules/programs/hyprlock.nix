{
  module-functions,
  hm,
  config,
  ...
}:
module-functions.module "programs" "hyprlock" {
  hm.programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
        no_fade_in = true;
      };

      background = {
        monitor = "";
        color = "rgb(${config.yunfachi.rice.colorscheme.base01.rgb})";
      };

      input-field = {
        monitor = "";
        size = "200, 50";

        outline_thickness = 0;
        dots_rounding = 0;
        rounding = 0;

        fade_on_empty = false;
        placeholder_text = "<span foreground=\"#${config.yunfachi.rice.colorscheme.base05.hex}\">Password:</span>";
        fail_text = "<span foreground=\"#${config.yunfachi.rice.colorscheme.base03.hex}\">Wrong</span>";

        inner_color = "rgb(${config.yunfachi.rice.colorscheme.base03.rgb})";
        font_color = "rgb(${config.yunfachi.rice.colorscheme.base05.rgb})";
        check_color = "rgb(${config.yunfachi.rice.colorscheme.base04.rgb})";
        fail_color = "rgb(${config.yunfachi.rice.colorscheme.base08.rgb})";
      };
    };
  };
}
