{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.teams";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled.persist.user.directories = [".config/teams-for-linux"];

  home.ifEnabled.home.packages = [pkgs.teams-for-linux];
}
