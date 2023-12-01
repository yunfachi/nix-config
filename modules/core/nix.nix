{
  inputs,
  lib,
  pkgs,
  ...
}: {
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixVersions.unstable;

    # https://www.foodogsquared.one/posts/2023-11-10-speeding-up-nixos-package-search-on-the-terminal/
    registry =
      lib.mapAttrs'
      (name: flake: let
        modifiedName =
          if (name == "self")
          then "config"
          else name;
      in
        lib.nameValuePair modifiedName {inherit flake;})
      inputs;
  };
}
