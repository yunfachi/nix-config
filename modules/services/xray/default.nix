{
  delib,
  host,
  ...
}:
delib.module {
  name = "services.xray";

  options.services.xray = with delib; {
    enable = boolOption host.isDesktop;
    type = enumOption ["client" "server"] (
      if host.isDesktop
      then "client"
      else "server"
    );
  };

  nixos.ifEnabled.services.xray = {
    enable = true;
    settings = {
      log.loglevel = "debug";
    };
  };
}
