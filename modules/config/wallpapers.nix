{
  delib,
  inputs,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "wallpapers";

  options.wallpapers = with delib; {
    images = attrsOfOption (submodule ({config, ...}: {
      options = {
        path = noDefault (pathOption null);
        tags = listOfOption str [];
        hash = strOption (builtins.hashFile "sha256" config.path);
      };
    })) {};
    excludedTags = listOfOption str [];

    interval = intOption 300000;

    imagesDir = noDefault (packageOption null);
  };

  myconfig.always = {cfg, ...}: {
    wallpapers = {
      images = lib.filterAttrs (_: wallpaper:
        !(builtins.any (
          tag: builtins.elem tag cfg.excludedTags
        ))
        wallpaper.tags)
      inputs.nix-config-wallpapers.wallpapers;

      imagesDir = pkgs.linkFarm "wallpapers" (map (image: {
        name = baseNameOf image.path;
        inherit (image) path;
      }) (builtins.attrValues cfg.images));
    };
  };

  home.always.home.packages = [inputs.wallpaper-manager.packages.${pkgs.system}.default];
}
