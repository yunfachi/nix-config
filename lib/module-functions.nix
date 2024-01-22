{
  lib,
  username,
  config,
  ...
}: let
  wrapContent = type: name: content: (
    if builtins.typeOf content == "lambda"
    then content config."${username}"."${type}"."${name}"
    else content
  );
in rec {
  # "type = if" is used here because "if then else" will cause infinite recursion
  moduleIfEnabled = type: name: content: {
    _type = "if";
    condition = config."${username}"."${type}"."${name}".enable;
    content = wrapContent type name content;
  };

  moduleIfDisabled = type: name: content: {
    _type = "if";
    condition = !config."${username}"."${type}"."${name}".enable;
    content = wrapContent type name content;
  };

  moduleIfElse = type: name: contentIfEnabled: contentIfDisabled:
    lib.mkMerge [
      (moduleIfEnabled type name contentIfEnabled)
      (moduleIfDisabled type name contentIfDisabled)
    ];

  moduleIfElseFinally = type: name: contentIfEnabled: contentIfDisabled: contentFinally:
    lib.mkMerge [
      (moduleIfElse type name contentIfEnabled contentIfDisabled)
      contentFinally
    ];

  module = moduleIfEnabled;
}
