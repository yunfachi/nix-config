{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.minecraft";

  myconfig.ifEnabled.persist.user.directories = [".minecraft"];

  options.programs.minecraft = with delib; {
    enable = boolOption host.isDesktop;

    enableLunarClient = boolOption true;
    enableModrinthApp = boolOption false;
  };
}
