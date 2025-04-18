{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.obsidian";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled.persist.user.directories = [".config/obsidian"];

  home.ifEnabled.home.packages = [pkgs.obsidian];
}
