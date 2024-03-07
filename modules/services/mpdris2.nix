{
  module-functions,
  hm,
  pkgs,
  config,
  ...
}:
module-functions.module "services" "mpdris2" {
  hm.services.mpdris2 = {
    enable = true;

    mpd = {
      host = "127.0.0.1";
      port = 6600;
      musicDirectory = config.hm.xdg.userDirs.music;
    };
  };
}
