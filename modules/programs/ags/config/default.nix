{
  delib,
  pkgs,
  colorscheme,
  lib,
  ...
}:
delib.module {
  name = "programs.ags";

  myconfig.always.programs.ags.configPackage = let
    #TODO: ideally the accent is the closest from the colorscheme to the one generated from the wallpaper (or set declaratively in nix-config-wallpapers)
    colorsScssFile = builtins.toFile "_colors.scss" ''
      $bg: ${colorscheme.base00.hex};
      $fg: ${colorscheme.base05.hex};
      $accent: ${colorscheme.base0B.hex};
    '';
  in
    pkgs.stdenv.mkDerivation {
      name = "yunfachi-ags-config";

      src = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.fileFilter (f: !f.hasExt "nix") ./.;
      };

      buildPhase = ''
        mkdir -p $out

        mkdir -p style
        cp ${colorsScssFile} style/globals/_colors.scss;

        cp -r * $out
      '';
    };
}
