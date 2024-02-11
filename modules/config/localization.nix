{
  module-functions,
  config,
  ...
}:
module-functions.module null "localization" (cfg: {
  time.timeZone = cfg.timezone;
  environment.variables.TZ = config.time.timeZone;

  i18n = {
    defaultLocale = cfg.locale;
    extraLocaleSettings = {
      LC_ADDRESS = cfg.locale;
      LC_COLLATE = cfg.locale;
      LC_IDENTIFICATION = cfg.locale;
      LC_MEASUREMENT = cfg.locale;
      LC_MONETARY = cfg.extraLocale;
      LC_NAME = cfg.locale;
      LC_NUMERIC = cfg.locale;
      LC_PAPER = cfg.extraLocale;
      LC_TELEPHONE = cfg.extraLocale;
      LC_TIME =
        if cfg.force24Hour
        then "C.UTF-8"
        else cfg.locale;
    };
  };
})
