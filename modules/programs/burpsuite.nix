{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.burpsuite";

  options = delib.singleEnableOption (host.guiFeatured && host.hackingFeatured);

  home.ifEnabled.home.packages = [pkgs.burpsuite];
}
