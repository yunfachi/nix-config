{
  delib,
  pkgs,
  homeconfig,
  ...
}:
delib.module {
  name = "programs.gpg";

  options = delib.singleEnableOption true;

  home.ifEnabled = {myconfig, ...}: {
    programs.gpg = {
      enable = true;

      homedir = "${homeconfig.xdg.dataHome}/gnupg";
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
