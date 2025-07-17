{
  delib,
  host,
  colorscheme,
  ...
}:
delib.module {
  name = "programs.kitty";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.programs.kitty = {
    enable = true;

    settings = with colorscheme; {
      enable_audio_bell = false;
      scrollback_lines = 10000;
      tab_bar_edge = "top";
      confirm_os_window_close = 0;
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";

      # https://github.com/Base24/base24-kitty-te/blob/32024a49ba4cd0bdd83b6a6cf6d578909f29fecf/templates/default.mustache
      background = base00.hex;
      foreground = base05.hex;
      selection_background = base05.hex;
      selection_foreground = base00.hex;
      url_color = base04.hex;
      cursor = base05.hex;
      active_border_color = base03.hex;
      inactive_border_color = base01.hex;
      active_tab_background = base00.hex;
      active_tab_foreground = base05.hex;
      inactive_tab_background = base01.hex;
      inactive_tab_foreground = base04.hex;
      color0 = base01.hex;
      color1 = base08.hex;
      color2 = base0B.hex;
      color3 = base09.hex;
      color4 = base0D.hex;
      color5 = base0E.hex;
      color6 = base0C.hex;
      color7 = base06.hex;
      color8 = base02.hex;
      color9 = base12.hex;
      color10 = base14.hex;
      color11 = base13.hex;
      color12 = base16.hex;
      color13 = base17.hex;
      color14 = base15.hex;
      color15 = base07.hex;
    };
  };
}
