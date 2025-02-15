{
  delib,
  pkgs,
  lib,
  ...
}: let
  shared.nix = {
    package = lib.mkForce pkgs.nixVersions.latest;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"];
      warn-dirty = false;
    };
  };
in
  delib.module {
    name = "nix";

    nixos.always = shared;
    home.always = shared;
  }
