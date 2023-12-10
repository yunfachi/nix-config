{config, ...}: {
  time.timeZone = "Europe/Madagascar";
  environment.variables.TZ = config.time.timeZone;

  i18n = let
    locale = "en_US.UTF-8";
    extraLocale = "ja_JP.UTF-8";
  in {
    defaultLocale = locale;
    extraLocaleSettings = {
      LC_ADDRESS = extraLocale;
      LC_COLLATE = locale;
      LC_IDENTIFICATION = extraLocale;
      LC_MEASUREMENT = extraLocale;
      LC_MONETARY = extraLocale;
      LC_NAME = extraLocale;
      LC_NUMERIC = extraLocale;
      LC_PAPER = extraLocale;
      LC_TELEPHONE = extraLocale;
      LC_TIME = extraLocale;
    };
  };
}
