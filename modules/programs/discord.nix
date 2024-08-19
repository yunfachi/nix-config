{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.discord";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled.home.packages = [
    (pkgs.discord-ptb.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}
