{
  lib,
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
in {
  option = type: name: content: {
    options."${username}"."${type}"."${name}" = content;
  };

  enableOption = name: default:
    lib.mkOption {
      inherit default;
      example = !default;
      description = "Whether to enable ${name}.";
      type = lib.types.bool;
    };

  enumOption = name: default: values:
    lib.mkOption {
      inherit default;
      example = findExample default values;
      description = "Whether to choose ${name}.";
      type = lib.types.enum values;
    };
}
