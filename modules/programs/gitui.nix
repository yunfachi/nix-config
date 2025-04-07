{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.gitui";

  options = delib.singleEnableOption host.cliFeatured;

  home.ifEnabled.programs.gitui.enable = true;
}
