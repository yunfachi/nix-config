{
  module-functions,
  lib,
  pkgs,
  config,
  ...
}: let
  getIfExists = attrset: key:
    if (attrset ? "${key}")
    then attrset."${key}"
    else "";
in
  module-functions.module "services" "postgresql" (cfg: {
    sops.templates."services/postgresql/initialScript" = {
      content = builtins.concatStringsSep " " cfg.initialScripts;
      owner = "postgres";
    };

    services.postgresql = {
      enable = true;
      enableTCPIP = cfg.enableTCPIP;
      package = pkgs.postgresql_16;

      ensureDatabases = cfg.databases;
      ensureUsers = lib.mapAttrsToList (name: value: {inherit name;} // value) cfg.users;

      authentication = lib.mkForce (
        lib.concatMapStringsSep "\n" (
          a: "${a.type} ${a.database} ${a.user} ${getIfExists a "address"} ${a.authMethod}"
        ) ([
            {
              type = "local";
              database = "all";
              user = "all";
              authMethod = "trust";
            }
          ]
          ++ cfg.authentications)
      );

      initialScript = config.sops.templates."services/postgresql/initialScript".path;
    };
  })
