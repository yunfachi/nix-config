{delib, ...}:
delib.module {
  name = "programs.fcitx5";

  home.ifEnabled.xdg.configFile."fcitx5/conf/mozc.conf" = {
    force = true;
    text = ''
      # Expand Usage
      ExpandMode="On Focus"
      # Hotkey to expand usage
      ExpandKey=
    '';
  };
}
