{
  module-functions,
  config,
  ...
}:
module-functions.module "infras" "deshiro" {
  sops.secrets."infras/deshiro/passwords/deshiro_api" = {};
  sops.secrets."infras/deshiro/passwords/deshiro_bot" = {};

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
      {
        type = "host";
        database = "deshiro";
        user = "deshiro_bot";
        address = "all";
        authMethod = "scram-sha-256";
      }
    ];
    initialScripts = [
      ''
         CREATE ROLE deshiro_api WITH LOGIN PASSWORD '${config.sops.placeholder."infras/deshiro/passwords/deshiro_api"}';
         CREATE ROLE deshiro_bot WITH LOGIN PASSWORD '${config.sops.placeholder."infras/deshiro/passwords/deshiro_bot"}';

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
          )
          CREATE TABLE staff (
            shikimori_id INTEGER NOT NULL UNIQUE,
            telegram_id BIGINT NOT NULL UNIQUE,
            rank INTEGER NOT NULL,
            CONSTRAINT rank_nonnegative CHECK (rank >= 0)
          );

        GRANT CONNECT ON DATABASE deshiro TO deshiro_api, deshiro_bot;
        GRANT USAGE ON SCHEMA deshiro TO deshiro_api, deshiro_bot;
        GRANT SELECT ON ALL TABLES IN SCHEMA deshiro TO deshiro_api, deshiro_bot;

        GRANT SELECT ON deshiro.staff TO deshiro_bot;
        GRANT INSERT, UPDATE, DELETE ON deshiro.animes TO deshiro_bot;
      ''
    ];

    databases = ["deshiro"];
    users = {
      deshiro_api = {
        ensureClauses.login = true;
      };
      deshiro_bot = {
        ensureClauses.login = true;
      };
    };
  };
}
