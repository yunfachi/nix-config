{
  delib,
  host,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.swww";

  options.programs.swww = with delib; {
    enable = boolOption host.isDesktop;
    enableCommands = boolOption true;
  };

  myconfig.ifEnabled = {
    cfg,
    myconfig,
    ...
  }: {
    commands.windowManager.onReload = lib.mkIf cfg.enableCommands [
      ''
        wallpaper-manager stop
        swww kill
        swww-daemon &
        wallpaper-manager start --dir ${myconfig.wallpapers.imagesDir} --interval ${toString myconfig.wallpapers.interval} --wallpaper-daemon swww
      ''
    ];
  };

  home.ifEnabled.home.packages = [pkgs.swww];
}
