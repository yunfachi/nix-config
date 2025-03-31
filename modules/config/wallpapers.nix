{
  delib,
  inputs,
  lib,
  host,
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
    wallpaperDaemon = allowNull (enumOption ["swww" "hyprpaper"] (
      if host.isDesktop
      then "swww"
      else null
    ));

    imagesDir = noDefault (packageOption null);
  };

  myconfig.always = {cfg, ...}: {
    wallpapers = {
      images = lib.filterAttrs (_: wallpaper:
        !(
          builtins.any
          (tag: builtins.elem tag cfg.excludedTags)
          wallpaper.tags
        ))
      inputs.nix-config-wallpapers.wallpapers;

      imagesDir = pkgs.linkFarm "wallpapers" (map (image: {
        name = baseNameOf image.path;
        inherit (image) path;
      }) (builtins.attrValues cfg.images));
    };
  };
}
