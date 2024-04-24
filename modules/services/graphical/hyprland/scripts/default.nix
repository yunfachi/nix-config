{
  module-functions,
  hm,
  lib,
  ...
}:
module-functions.module "services" "hyprland" {
  hm.xdg.configFile."hypr/scripts" = {
    recursive = true;
    source = (lib.fileset.toSource {
      root = ./.;
      fileset = lib.fileset.fileFilter (file: file.hasExt "sh") ./.;
    }).outPath;
  };
}
