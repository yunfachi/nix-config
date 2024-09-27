{delib, ...}:
delib.module {
  name = "programs.fcitx5";

  home.ifEnabled.xdg.configFile."fcitx5/profile" = {
    force = true;
    text = ''
      [Groups/0]
      Name=default
      Default Layout=us
      DefaultIM=keyboard-ru

      [Groups/0/Items/0]
      Name=keyboard-us
      Layout=

      [Groups/0/Items/1]
      Name=keyboard-ru
      Layout=

      [Groups/1]
      Name=japanese
      Default Layout=jp
      DefaultIM=keyboard-us

      [Groups/1/Items/0]
      Name=mozc
      Layout=

      [Groups/1/Items/1]
      Name=keyboard-us
      Layout=

      [GroupOrder]
      0=Default
      1=japanese
    '';
  };
}
