{
  option-functions,
  options,
  ...
}: let
  usersType =
    removeAttrs
    (builtins.elemAt
      (
        builtins.elemAt
        options.services.postgresql.ensureUsers.type.nestedTypes.elemType.functor.payload.modules
        0
      )
      .imports
      0)
    .options ["name"];
in
  with option-functions; {
    options.yunfachi.services.postgresql = {
      enable = enableOption "postgresql" false;
      enableRemote = enableOption "remote" true;

      databases = listOption "databases" [] types.str;
      users = attrsOption "users" {} (submoduleOption usersType);

      authentications = listOption "authentications" [] (submoduleOption {
        type = enumOption "type" null ["local" "host"];
        database = textOption "database" null;
        user = textOption "user" null;
        address = textOption "address" "";
        authMethod =
          enumOption "auth method" null
          ["trust" "reject" "scram-sha-256" "md5" "password" "gss" "sspi" "ident" "peer" "ldap" "radius" "cert" "pam" "bsd"];
      });

      initialScripts = listOption "initial scripts" [] types.str;
    };
  }
