{
  module-functions,
  config,
  hm,
  pkgs,
  lib,
  host,
  ...
}:
module-functions.module "programs" "eww" (cfg: {
  hm.programs.eww = {
    enable = true;
    package = pkgs.eww;

    # we do not use symlinkJoin here, because eww does not work with symlink
    configDir = pkgs.stdenv.mkDerivation {
      name = "yunfachi-eww-config";
      src = pkgs.symlinkJoin {
        name = "yunfachi-eww-config-links";
        paths =
          [
            (lib.fileset.toSource {
              root = ./config;
              fileset = lib.fileset.fileFilter (file: !file.hasExt "nix") ./config;
            })
          ]
          ++ map (attrs: {
            name = "eww-config-${lib.nameFromURL attrs.name "."}";
            inherit (pkgs.writeTextDir attrs.name attrs.value) outPath;
          }) (lib.attrsToList cfg.config);
      };
      installPhase = ''
        mkdir $out
        cp -Lr * $out
      '';
    };
  };

  yunfachi = {
    commands.onGraphical.reload = [
      ''
        pkill -c eww
        ${config.hm.programs.eww.package}/bin/eww daemon
        ${config.hm.programs.eww.package}/bin/eww open-many window_top_bar
      ''
    ];
    services.hyprland.commands.onReload = [
      ''
        ${config.hm.wayland.windowManager.hyprland.package}/bin/hyprctl \
          --batch "keyword monitor ,addreserved,${toString (config.yunfachi.rice.gaps.outer + config.yunfachi.rice.bar_height)},0,0,0"
      ''
    ];
  };
})
