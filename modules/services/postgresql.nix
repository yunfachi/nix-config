{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "services.postgresql";

  options.services.postgresql = with delib; {
    enable = boolOption false;

    openFirewall = boolOption false;
    port = portOption 5432;
    listen_addresses = listOfOption str [ ];
    extraSettings = attrsOption { };

    package = packageOption pkgs.postgresql_16;
    extensions = coercedToOption (listOf path) (path: _: path) (lambdaTo (listOf path)) (_: [ ]);

    databases = listOfOption str [ ];
    users = attrsOfOption attrs { };

    authentications = listOfOption (submodule {
      options = {
        type = noDefault (enumOption [ "local" "host" ] null);
        database = noDefault (strOption null);
        user = noDefault (strOption null);
        address = strOption "";
        authMethod = noDefault (
          enumOption [
            "trust"
            "reject"
            "scram-sha-256"
            "md5"
            "password"
            "gss"
            "sspi"
            "ident"
            "peer"
            "ldap"
            "radius"
            "cert"
            "pam"
            "bsd"
          ] null
        );
      };
    }) [ ];

    initialScripts = listOfOption str [ ];
  };

  myconfig.ifEnabled.persist.directories = [ "/var/lib/postgresql" ];

  nixos.ifEnabled =
    { cfg, ... }:
    {
      networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ cfg.port ];

      services.postgresql = {
        enable = true;

        inherit (cfg) package extensions;

        ensureDatabases = cfg.databases;
        ensureUsers = lib.mapAttrsToList (name: value: { inherit name; } // value) cfg.users;

        initialScript = builtins.toFile "postgresql-initialScript" (
          builtins.concatStringsSep " " cfg.initialScripts
        );

        authentication = lib.mkForce (
          lib.concatMapStringsSep "\n" (a: "${a.type} ${a.database} ${a.user} ${a.address} ${a.authMethod}") (
            [
              {
                type = "local";
                database = "all";
                user = "all";
                address = "";
                authMethod = "trust";
              }
            ]
            ++ cfg.authentications
          )
        );

        settings = {
          inherit (cfg) port;
          listen_addresses = lib.mkForce (builtins.concatStringsSep ", " cfg.listen_addresses);
        }
        // cfg.extraSettings;
      };
    };
}
