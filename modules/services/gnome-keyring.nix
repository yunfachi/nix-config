{
  delib,
  host,
  ...
}:
delib.module {
  name = "services.gnome-keyring";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.ifEnabled.persist.user.directories = [".local/share/keyrings"];

  home.ifEnabled.services.gnome-keyring.enable = true;
}
