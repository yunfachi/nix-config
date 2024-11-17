{delib, ...}:
delib.module {
  name = "services.immich";

  myconfig.ifEnabled = {cfg, ...}: {
    services.postgresql = {
      enable = true;

      extraPlugins = ps: with ps; [pgvecto-rs];
      extraSettings.shared_preload_libraries = ["vectors.so"];

      databases = [cfg.database.name];
      users.${cfg.database.user} = {
        ensureDBOwnership = true;
        ensureClauses.login = true;
      };

      initialScripts = [
        ''
          CREATE ROLE ${cfg.database.user};
          CREATE DATABASE ${cfg.database.name} OWNER ${cfg.database.user};

          \connect ${cfg.database.name};

          CREATE EXTENSION IF NOT EXISTS vectors;
          CREATE EXTENSION IF NOT EXISTS earthdistance CASCADE;

          ALTER DATABASE ${cfg.database.name} SET search_path TO "$user", public, vectors;
          ALTER SCHEMA vectors OWNER TO ${cfg.database.user};
        ''
      ];
    };
  };
}
