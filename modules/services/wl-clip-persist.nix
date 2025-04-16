{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.wl-clip-persist";

  # TODO: host.isWayland ?
  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled.commands.windowManager.onReload = [
    ''
      pkill -f wl-clip-persist-windowsManager-onReload
      exec -a wl-clip-persist-windowsManager-onReload wl-clip-persist --clipboard regular
    ''
  ];

  home.ifEnabled.home.packages = [pkgs.wl-clip-persist];
}
