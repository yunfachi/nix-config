{pkgs, ...}: {
  programs.kitty = {
    enable = true;

    settings = {
      background_opacity = "0.25";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      scrollback_lines = 10000;
    };
  };
}
