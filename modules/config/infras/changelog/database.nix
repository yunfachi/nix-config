{
  module-functions,
  config,
  ...
}:
module-functions.module "infras" "changelog" {
  sops.secrets."infras/changelog/passwords/changelog_bot" = {};

  yunfachi.services.postgresql = {
    enable = true;

    authentications = [
      {
        type = "host";
        database = "changelog";
        user = "changelog_bot";
        address = "all";
        authMethod = "scram-sha-256";
      }
    ];
    initialScripts = [
      ''
         CREATE ROLE changelog_bot WITH LOGIN PASSWORD '${config.sops.placeholder."infras/changelog/passwords/changelog_bot"}';
        CREATE DATABASE changelog WITH OWNER changelog_bot;
      ''
    ];

    databases = ["changelog"];
    users = {
      changelog_bot = {
        ensureClauses.login = true;
      };
    };
  };
}
