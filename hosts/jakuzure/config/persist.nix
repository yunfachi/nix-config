{delib, ...}:
delib.host {
  name = "jakuzure";

  myconfig.persist = {
    enable = true;
    persistPath = "/persist";
  };
}
