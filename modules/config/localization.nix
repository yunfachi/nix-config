{
  delib,
  host,
  ...
}:
delib.module {
  name = "localization";

  options.localization = with delib; {
    enable = boolOption host.isDesktop;

    timeZone = strOption "Etc/GMT-3";
    force24Hour = boolOption true;

    locale = strOption "en_US.UTF-8";
    extraLocale = strOption "ja_JP.UTF-8";
    installAllLocales = boolOption host.isDesktop;
  };

  nixos.ifEnabled = {cfg, ...}: {
    time.timeZone = cfg.timeZone;
    environment.variables.TZ = cfg.timeZone;

    i18n = {
      defaultLocale = cfg.locale;
      extraLocaleSettings = {
        LC_ADDRESS = cfg.locale;
        LC_COLLATE = cfg.locale;
        LC_IDENTIFICATION = cfg.locale;
        LC_MEASUREMENT = cfg.locale;
        LC_NAME = cfg.locale;
        LC_NUMERIC = cfg.locale;
        LC_MONETARY = cfg.extraLocale;
        LC_PAPER = cfg.extraLocale;
        LC_TELEPHONE = cfg.extraLocale;
        LC_TIME =
          if cfg.force24Hour
          then "C.UTF-8"
          else cfg.locale;
      };

      # Installing all locales solves bugs in some applications
      supportedLocales =
        if cfg.installAllLocales
        then ["all"]
        else [
          "${cfg.locale}/UTF-8"
          "${cfg.extraLocale}/UTF-8"
          "C.UTF-8/UTF-8"
          "ru_RU.UTF-8/UTF-8"
        ];
    };
  };
}
