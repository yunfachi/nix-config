{
  delib,
  host,
  ...
}:
delib.module {
  name = "services.gnome-keyring";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled.persist.user.directories = [".local/share/keyrings"];

  home.ifEnabled.services.gnome-keyring.enable = true;
}
