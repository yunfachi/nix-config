{delib, ...}:
delib.module {
  name = "programs.fcitx5";

  home.ifEnabled.xdg.configFile."fcitx5/profile" = {
    force = true;
    text = ''
      [Groups/0]
      Name=default
      Default Layout=us
      DefaultIM=mozc

      [Groups/0/Items/0]
      Name=mozc
      Layout=

      [GroupOrder]
      0=Default
    '';
  };
}
