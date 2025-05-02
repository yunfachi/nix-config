{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.minecraft";

  options = delib.singleEnableOption (host.guiFeatured && host.gamingFeatured);

  myconfig.ifEnabled.persist.user.directories = [".minecraft"];
}
