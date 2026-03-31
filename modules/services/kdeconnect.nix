{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "services.kdeconnect";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.ifEnabled.persist.user.directories = [".config/kdeconnect"];

  home.ifEnabled.services.kdeconnect = {
    enable = true;
  };

  nixos.ifEnabled.programs.kdeconnect = {
    enable = true;
  };
}
