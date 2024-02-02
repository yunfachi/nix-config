{
  module-functions,
  hm,
  ...
}:
module-functions.module "programs" "kitty" {
  hm.programs.kitty = {
    enable = true;

    settings = {
      enable_audio_bell = false;
      scrollback_lines = 10000;
      tab_bar_edge = "top";
      confirm_os_window_close = 0;
    };
  };
}
