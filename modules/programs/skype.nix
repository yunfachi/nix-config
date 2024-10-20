{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.skype";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.ifEnabled.persist.user.directories = [".config/skypeforlinux"];

  home.ifEnabled.home.packages = [pkgs.skypeforlinux];
}
