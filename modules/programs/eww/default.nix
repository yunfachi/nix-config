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
    package = with pkgs; (
      if host.isWayland
      then eww-wayland
      else eww
    );

    configDir = pkgs.symlinkJoin {
      name = "yunfachi-eww-config";
      paths =
        [
          {
            name = "eww-config-bin";
            outPath = ./config/bin;
          }
        ]
        ++ map (attrs: {
          name = "eww-config-${lib.nameFromURL attrs.name "."}";
          inherit (pkgs.writeTextDir attrs.name attrs.value) outPath;
        }) (lib.attrsToList cfg.config);
    };
  };

  yunfachi = {
    startup.commands.onGraphical = [
      ''
        ${config.hm.programs.eww.package}/bin/eww daemon
        ${config.hm.programs.eww.package}/bin/eww open-many window_top_bar
      ''
    ];
    services.hyprland.startupCommands = [
      ''
        ${config.hm.wayland.windowManager.hyprland.package}/bin/hyprctl \
          --batch "keyword monitor ,addreserved,${toString (cfg.bar.y + cfg.bar.height)},0,0,0"
      ''
    ];
  };
})
