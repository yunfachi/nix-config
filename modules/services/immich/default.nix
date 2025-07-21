{
  delib,
  wireguardLocalAddress,
  ...
}:
delib.module {
  name = "services.immich";

  options.services.immich = with delib; {
    enable = boolOption false;

    host = strOption (
      if wireguardLocalAddress != null
      then wireguardLocalAddress
      else "localhost"
    );
    port = intOption 2283;
    openFirewall = boolOption true;

    database = {
      name = strOption "immich";
      user = strOption "immich";
    };

    settings = allowNull (attrsOption null);
    mediaLocation = pathOption "/var/lib/immich";
  };

  nixos.ifEnabled = {
    myconfig,
    cfg,
    ...
  }: {
    services.immich = {
      enable = true;

      inherit
        (cfg)
        host
        port
        openFirewall
        settings
        mediaLocation
        ;

      database = {
        enable = false;
        port = myconfig.services.postgresql.port;
        inherit (cfg.database) name user;
      };
    };

    users.users.immich.extraGroups = [
      "video"
      "render"
    ];
  };
}
