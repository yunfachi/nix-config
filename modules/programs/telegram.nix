{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.telegram";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled.home.packages = [pkgs.kotatogram-desktop];
}
