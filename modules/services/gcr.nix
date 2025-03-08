{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "services.gcr";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled.services.dbus.packages = [pkgs.gcr];
}
