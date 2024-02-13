{option-functions, ...}:
with option-functions;
  option null "localization" {
    timezone = textOption "timezone" "Etc/GMT-3";
    force24Hour = enableOption "Military time (24-hour clock)" true;

    locale = textOption "locale" "en_US.UTF-8";
    extraLocale = textOption "extraLocale" "ja_JP.UTF-8";
  }
