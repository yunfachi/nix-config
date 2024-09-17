{
  delib,
  decryptSecret,
  ...
}:
delib.module {
  name = "infras.changelog";

  myconfig.ifEnabled.services.postgresql = {
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
    databases = ["changelog"];
    users = {
      changelog_bot = {
        ensureClauses.login = true;
      };
    };

    initialScripts = [
      ''
         CREATE ROLE changelog_bot WITH LOGIN PASSWORD '${decryptSecret "infras/changelog/postgresql/passwords/changelog_bot"}';
        CREATE DATABASE changelog WITH OWNER changelog_bot;
      ''
    ];
  };
}
