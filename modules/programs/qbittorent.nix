{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.qbittorent";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.ifEnabled.persist.user.directories = [".config/qBittorrent" ".local/share/qBittorrent" ".cache/qBittorrent"];

  home.ifEnabled.home.packages = [pkgs.qbittorrent];
}
