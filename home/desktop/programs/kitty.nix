{...}: {
  programs.kitty = {
    enable = true;

    settings = {
      term = "xterm-256color";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      scrollback_lines = 10000;
      placement_strategy = "top-left";
    };
  };
}
