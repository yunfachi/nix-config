{
  module-functions,
  lib,
  pkgs,
  config,
  hm,
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

    environment.sessionVariables.PSQL_HISTORY = "/dev/null";
    hm.home.file.".psqlrc".text = ''
      \set HISTCONTROL 'ignoreboth'
      \set HISTFILE /dev/null
      \set HISTSIZE 0
    '';

    networking.firewall.allowedTCPPorts = lib.mkIf cfg.enableRemote [config.services.postgresql.port];

    services.postgresql = {
      enable = true;
      enableTCPIP = true;
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
