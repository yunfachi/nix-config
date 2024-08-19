{delib, ...}: let
  shared.nixpkgs.config = {
    allowUnfree = true;
  };
in
  delib.module {
    name = "nixpkgs";

    nixos.always = shared;
    home.always = shared;
  }
