{
  module-functions,
  config,
  ...
}:
module-functions.module "infras" "deshiro" {
  sops.secrets."infras/deshiro/passwords/deshiro_api" = {};

  yunfachi.services.postgresql = {
    enable = true;

    authentications = [
      {
        type = "host";
        database = "deshiro";
        user = "deshiro_api";
        address = "all";
        authMethod = "scram-sha-256";
      }
    ];
    initialScripts = [
      ''
         CREATE ROLE deshiro_api WITH LOGIN PASSWORD '${config.sops.placeholder."infras/deshiro/passwords/deshiro_api"}';
        CREATE DATABASE deshiro;

        \connect deshiro;

        CREATE SCHEMA deshiro
          CREATE TABLE animes (
            id INTEGER NOT NULL UNIQUE,
            message TEXT,
            CONSTRAINT message_not_empty CHECK (message <> ''')
          )
          CREATE TABLE constants (
            key TEXT NOT NULL UNIQUE,
            value TEXT
          );

        GRANT CONNECT ON DATABASE deshiro TO deshiro_api;
        GRANT USAGE ON SCHEMA deshiro TO deshiro_api;
        GRANT SELECT ON ALL TABLES IN SCHEMA deshiro TO deshiro_api;
      ''
    ];

    databases = ["deshiro"];
    users = {
      deshiro_api = {
        ensureClauses.login = true;
      };
    };
  };
}
