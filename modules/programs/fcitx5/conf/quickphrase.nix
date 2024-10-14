{delib, ...}:
delib.module {
  name = "programs.fcitx5";

  home.ifEnabled.xdg.configFile."fcitx5/conf/quickphrase.conf" = {
    force = true;
    text = ''
      # Trigger Key
      TriggerKey=
      # Choose key modifier
      Choose Modifier=None
      # Enable Spell check
      Spell=True
      # Fallback Spell check language
      FallbackSpellLanguage=en
    '';
  };
}
