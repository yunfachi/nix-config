{
  delib,
  pkgs,
  homeconfig,
  ...
}:
delib.module {
  name = "programs.gpg";

  options = delib.singleEnableOption true;

  myconfig.ifEnabled.persist.user.directories = [
    {
      directory = ".gnupg";
      mode = "u=rwx,g=,o=";
    }
  ];

  home.ifEnabled = {myconfig, ...}: {
    programs.gpg = {
      enable = true;

      homedir = "${homeconfig.home.homeDirectory}/.gnupg";
    };

    services.gpg-agent = {
      enable = true;
      pinentryPackage =
        if myconfig.services.gcr.enable
        then pkgs.pinentry-gnome3
        else pkgs.pinentry-curses;
    };
  };
}
