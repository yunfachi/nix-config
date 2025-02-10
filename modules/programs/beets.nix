{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.beets";

  options.programs.beets = with delib; {
    enable = boolOption host.isDesktop;
    settings = attrsOption {};
  };

  home.ifEnabled = {cfg, ...}: {
    programs.beets = {
      enable = true;
      inherit (cfg) settings;
    };
  };
}
