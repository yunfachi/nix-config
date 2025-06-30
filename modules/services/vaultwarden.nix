{
  delib,
  lib,
  wireguardLocalAddress,
  ...
}:
delib.module {
  name = "services.vaultwarden";

  options = {
    myconfig,
    cfg,
    ...
  }: {
    services.vaultwarden = with delib; {
      enable = boolOption false;
      address = strOption (
        if wireguardLocalAddress != null
        then wireguardLocalAddress
        else "127.0.0.1"
      );
      port = intOption 8222;
      domain = allowNull (strOption null);
      database = {
        backend = enumOption ["sqlite" "postgresql"] (
          if myconfig.services.postgresql.enable
          then "postgresql"
          else "sqlite"
        );
        password = strOption null;
        url = strOption (
          if cfg.database.backend == "postgresql"
          then "postgresql://vaultwarden:${cfg.database.password}@/vaultwarden?host=/run/postgresql"
          else null
        );
      };
    };
  };

  myconfig.ifEnabled = {cfg, ...}: {
    services.postgresql = lib.mkIf (cfg.database.backend == "postgresql") {
      authentications = [
        {
          type = "local";
          database = "vaultwarden";
          user = "vaultwarden";
          authMethod = "scram-sha-256";
        }
      ];
      databases = ["vaultwarden"];
      users.vaultwarden = {
        ensureClauses.login = true;
        ensureDBOwnership = true;
      };

      initialScripts = [
        ''
           CREATE ROLE vaultwarden WITH LOGIN PASSWORD '${cfg.database.password}';

          CREATE DATABASE vaultwarden WITH OWNER vaultwarden;
        ''
      ];
    };
  };

  nixos.ifEnabled = {cfg, ...}: {
    networking.firewall.allowedTCPPorts = [cfg.port];

    services.vaultwarden = {
      enable = true;
      dbBackend = cfg.database.backend;
      config = {
        DATABASE_URL = lib.mkIf (cfg.database.backend != "sqlite") cfg.database.url;
        ROCKET_ADDRESS = cfg.address;
        ROCKET_PORT = cfg.port;
        DOMAIN = lib.mkIf (cfg.domain != null) cfg.domain;
      };
    };
  };
}
