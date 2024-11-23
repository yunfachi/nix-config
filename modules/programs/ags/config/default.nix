{
  delib,
  pkgs,
  lib,
  colorscheme,
  ...
}:
delib.module {
  name = "programs.ags";

  myconfig.always.programs.ags.configPackage = let
    #TODO: ideally the accent is the closest from the colorscheme to the one generated from the wallpaper (or set declaratively in nix-config-wallpapers)
    colors = builtins.toFile "colors.scss" ''
      $bg: ${colorscheme.base00.hex};
      $fg: ${colorscheme.base05.hex};
      $accent: ${colorscheme.base0B.hex};
    '';
  in
    pkgs.stdenv.mkDerivation {
      name = "yunfachi-ags-config";

      src = lib.fileset.toSource {
        root = ./.;
        fileset = ./.;
      };

      buildPhase = ''
        cp ${colors} style/colors.scss
        cp ./. -r $out
      '';

      nativeBuildInputs = with pkgs; [bun tailwindcss dart-sass];
    };
}
