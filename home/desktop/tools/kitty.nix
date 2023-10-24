{pkgs, ...}: {
  programs.kitty = {
    enable = true;

    settings = {
      term = "xterm-256color";
      background_opacity = "0.25";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      scrollback_lines = 10000;
      placement_strategy = "top-left";
    };
  };
}
