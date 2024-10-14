{delib, ...}:
delib.module {
  name = "programs.fcitx5";

  home.ifEnabled.xdg.configFile."fcitx5/conf/waylandim.conf" = {
    force = true;
    text = ''
      # Detect current running application (Need restart)
      DetectApplication=True
      # Forward key event instead of commiting text if it is not handled
      PreferKeyEvent=True
    '';
  };
}
