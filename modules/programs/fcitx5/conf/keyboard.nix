{delib, ...}:
delib.module {
  name = "programs.fcitx5";

  home.ifEnabled.xdg.configFile."fcitx5/conf/keyboard.conf" = {
    force = true;
    text = ''
      # Page size
      PageSize=5
      # Enable emoji in hint
      EnableEmoji=True
      # Enable emoji in quickphrase
      EnableQuickPhraseEmoji=True
      # Choose key modifier
      Choose Modifier=Alt
      # Enable hint by default
      EnableHintByDefault=False
      # Trigger hint mode
      Hint Trigger=
      # Trigger hint mode for one time
      One Time Hint Trigger=
      # Use new compose behavior
      UseNewComposeBehavior=True
      # Type special characters with long press
      EnableLongPress=False

      [PrevCandidate]
      0=Shift+Tab

      [NextCandidate]
      0=Tab

      [LongPressBlocklist]
      0=konsole
    '';
  };
}
