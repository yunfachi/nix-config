{delib, ...}:
delib.host {
  name = "jakuzure";

  myconfig.services.immich = {
    enable = true;

    mediaLocation = "/media/immich";
    host = "0.0.0.0";
  };
}
