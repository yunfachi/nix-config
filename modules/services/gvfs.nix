{
  delib,
  host,
  ...
}:
delib.module {
  name = "services.gvfs";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled.services.gvfs.enable = true;
}
