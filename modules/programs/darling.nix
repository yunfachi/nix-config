{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.darling";

  options = delib.singleEnableOption host.isDesktop;

  nixos.ifEnabled.programs.darling.enable = true;
}
