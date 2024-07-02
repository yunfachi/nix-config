{
  lib,
  config,
  username,
  ...
}: rec {
  moduleRaw = {
    type ? null,
    name,
    contentIfEnabled ? {},
    contentIfDisabled ? {},
    contentFinally ? {},
    root ? false,
  }: let
    config1 =
      if !root
      then config.${username}
      else config;
    config2 =
      if type != null
      then config1.${type}.${name}
      else config1.${name};

    wrapContent = content:
      if builtins.typeOf content == "lambda"
      then content config2
      else content;

    condition = config2.enable or true;
  in {
    imports = [
      {
        inherit condition;
        _type = "if";
        content = wrapContent contentIfEnabled;
      }
      {
        condition = !condition;
        _type = "if";
        content = wrapContent contentIfDisabled;
      }
      (wrapContent contentFinally)
    ];
  };

  moduleIfEnabled = type: name: contentIfEnabled:
    moduleRaw {
      inherit type name contentIfEnabled;
    };
  moduleIfDisabled = type: name: contentIfDisabled:
    moduleRaw {
      inherit type name contentIfDisabled;
    };
  moduleIfEnabledFinally = type: name: contentIfEnabled: contentFinally:
    moduleRaw {
      inherit type name contentIfEnabled contentFinally;
    };
  moduleIfDisabledFinally = type: name: contentIfDisabled: contentFinally:
    moduleRaw {
      inherit type name contentIfDisabled contentFinally;
    };
  moduleIfElse = type: name: contentIfEnabled: contentIfDisabled:
    moduleRaw {
      inherit type name contentIfEnabled contentIfDisabled;
    };
  moduleIfElseFinally = type: name: contentIfEnabled: contentIfDisabled: contentFinally:
    moduleRaw {
      inherit type name contentIfEnabled contentIfDisabled contentFinally;
    };

  rootModuleIfEnabled = type: name: contentIfDisabled:
    moduleRaw {
      inherit type name contentIfDisabled;
      root = true;
    };
  rootModuleIfDisabled = type: name: contentIfDisabled:
    moduleRaw {
      inherit type name contentIfDisabled;
      root = true;
    };
  rootModuleIfEnabledFinally = type: name: contentIfEnabled: contentFinally:
    moduleRaw {
      inherit type name contentIfEnabled contentFinally;
      root = true;
    };
  rootModuleIfDisabledFinally = type: name: contentIfDisabled: contentFinally:
    moduleRaw {
      inherit type name contentIfDisabled contentFinally;
      root = true;
    };
  rootModuleIfElse = type: name: contentIfEnabled: contentIfDisabled:
    moduleRaw {
      inherit type name contentIfEnabled contentIfDisabled;
      root = true;
    };
  rootModuleIfElseFinally = type: name: contentIfEnabled: contentIfDisabled: contentFinally:
    moduleRaw {
      inherit type name contentIfEnabled contentIfDisabled contentFinally;
      root = true;
    };

  module = moduleIfEnabled;
  rootModule = rootModuleIfEnabled;
}
