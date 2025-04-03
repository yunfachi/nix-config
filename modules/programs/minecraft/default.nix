{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.minecraft";

  myconfig.ifEnabled.persist.user.directories = [".minecraft"];

  options.programs.minecraft = with delib; {
    enable = boolOption (host.guiFeatured && host.gamingFeatured);

    enableLunarClient = boolOption true;
  };
}
