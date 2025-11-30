{
  delib,
  inputs,
  pkgs,
  ...
}: let
  args = {
    ylib = inputs.nypkgs.lib.${pkgs.stdenv.hostPlatform.system};
    ypkgs = inputs.nypkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  };
in
  delib.module {
    name = "nypkgs";

    nixos.always._module.args = args;
    home.always._module.args = args;
  }
