{delib, ...}:
delib.host {
  name = "jakuzure";

  myconfig.services.navidrome = {
    enable = true;

    openFirewall = true;
    address = "0.0.0.0";

    folder = "/media/music";
  };
}
