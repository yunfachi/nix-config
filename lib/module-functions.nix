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
    negate ? false,
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

    condition =
      if !negate
      then config2.enable or true
      else !config2.enable or true;
  in
    lib.mkMerge [
      {
        inherit condition;
        _type = "if";
        content = wrapContent contentIfEnabled;
      }
      {
        inherit condition;
        _type = "if";
        content = wrapContent contentIfDisabled;
      }
      (wrapContent contentFinally)
    ];

  moduleIfEnabled = type: name: contentIfEnabled:
    moduleRaw {
      inherit type name contentIfEnabled;
    };
  moduleIfDisabled = type: name: contentIfEnabled:
    moduleRaw {
      inherit type name contentIfEnabled;
      negate = true;
    };
  moduleIfElse = type: name: contentIfEnabled: contentIfDisabled:
    moduleRaw {
      inherit type name contentIfEnabled contentIfDisabled;
    };
  moduleIfElseFinally = type: name: contentIfEnabled: contentIfDisabled: contentFinally:
    moduleRaw {
      inherit type name contentIfEnabled contentIfDisabled contentFinally;
    };

  rootModuleIfEnabled = type: name: contentIfEnabled:
    moduleRaw {
      inherit type name contentIfEnabled;
      root = true;
    };
  rootModuleIfDisabled = type: name: contentIfEnabled:
    moduleRaw {
      inherit type name contentIfEnabled;
      negate = true;
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
