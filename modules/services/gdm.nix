{
  delib,
  host,
  ...
}:
delib.module {
  name = "services.gdm";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled.services.displayManager.gdm = {
    enable = true;
  };
}
