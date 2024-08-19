{
  delib,
  pkgs,
  lib,
  ...
}: let
  shared.nix = {
    package = lib.mkForce pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
in
  delib.module {
    name = "nix";

    nixos.always = shared;
    home.always = shared;
  }
