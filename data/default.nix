{lib, ...}:
lib.concatMapAttrs (
  name: _: {
    ${
      (builtins.elemAt (lib.splitString "." name) 0)
    } =
      import ./${name};
  }
) (builtins.removeAttrs (builtins.readDir ./.) ["default.nix"])
