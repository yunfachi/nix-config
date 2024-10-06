{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "services.gcr";

  options = delib.singleEnableOption host.isDesktop;

  nixos.ifEnabled.services.dbus.packages = [pkgs.gcr];
}
