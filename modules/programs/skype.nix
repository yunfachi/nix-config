{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.skype";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled.home.packages = [pkgs.skypeforlinux];
}
