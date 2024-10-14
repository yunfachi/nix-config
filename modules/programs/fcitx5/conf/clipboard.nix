{delib, ...}:
delib.module {
  name = "programs.fcitx5";

  home.ifEnabled.xdg.configFile."fcitx5/conf/clipboard.conf" = {
    force = true;
    text = ''
      # Trigger Key
      TriggerKey=
      # Paste Primary
      PastePrimaryKey=
      # Number of entries
      Number of entries=5
      # Do not show password from password managers
      IgnorePasswordFromPasswordManager=False
      # Hidden clipboard content that contains a password
      ShowPassword=False
      # Seconds before clearing password
      ClearPasswordAfter=30
    '';
  };
}
