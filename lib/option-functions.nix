{
  lib,
  config,
  username,
  ...
}: let
  findExample = value: values: let
    filteredValues = builtins.filter (v: v != null && v != value) values;
  in
    if builtins.length filteredValues > 0
    then builtins.elemAt filteredValues 0
    else if builtins.length values > 1
    then builtins.elemAt values 1
    else value;

  wrapContent = type: name: content: root:
    if builtins.typeOf content == "lambda"
    then
      content (
        if type != null
        then
          (
            if root
            then config."${type}"."${name}"
            else config."${username}"."${type}"."${name}"
          )
        else
          (
            if root
            then config."${name}"
            else config."${username}"."${name}"
          )
      )
    else content;
in {
  inherit (lib) types;

  option = type: name: content:
    if (type != null)
    then {options."${username}"."${type}"."${name}" = wrapContent type name content false;}
    else {options."${username}"."${name}" = wrapContent type name content false;};

  rootOption = type: name: content:
    if (type != null)
    then {options."${type}"."${name}" = wrapContent type name content true;}
    else {options."${name}" = wrapContent type name content true;};

  enableOption = name: default:
    lib.mkOption {
      inherit default;
      example = !default;
      description = "Whether to enable ${name}.";
      type = lib.types.bool;
    };

  textOption = name: default:
    lib.mkOption {
      inherit default;
      example = "Hoge";
      description = "Whether to specify ${name}.";
      type = lib.types.str;
    };

  numberOption = name: default:
    lib.mkOption {
      inherit default;
      example = 110;
      description = "Whether to specify ${name}.";
      type = lib.types.number;
    };

  enumOption = name: default: values:
    lib.mkOption {
      inherit default;
      example = findExample default values;
      description = "Whether to choose ${name}.";
      type = lib.types.enum values;
    };

  listOption = name: default: type:
    lib.mkOption {
      inherit default;
      example = [];
      description = "Whether to specify ${name}.";
      type = lib.types.listOf type;
    };

  attrsOption = name: default: type:
    lib.mkOption {
      inherit default;
      example = [];
      description = "Whether to specify ${name}.";
      type = lib.types.attrsOf type;
    };

  submoduleOption = content:
    lib.types.submodule (
      if (builtins.typeOf content) == "lambda"
      then content
      else {options = content;}
    );

  customOption = default: type:
    lib.mkOption {
      inherit default type;
    };
}
