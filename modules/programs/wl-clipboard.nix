{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.wl-clipboard";

  # TODO: host.isWayland ?
  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.wl-clipboard];
}
