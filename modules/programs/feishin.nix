{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.feishin";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.ifEnabled.persist.user.directories = [".config/feishin"];

  home.ifEnabled.home.packages = [pkgs.feishin];
}
