{delib, ...}:
delib.module {
  name = "programs.fcitx5";

  home.ifEnabled.xdg.configFile."fcitx5/conf/unicode.conf" = {
    force = true;
    text = ''
      [TriggerKey]
      0=Control+Alt+Shift+U

      [DirectUnicodeMode]
      0=Control+Shift+U
    '';
  };
}
