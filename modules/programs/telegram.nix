{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.telegram";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.ifEnabled.persist.user.directories = [".local/share/KotatogramDesktop/tdata"];

  home.ifEnabled.home.packages = [pkgs.kotatogram-desktop];
}
