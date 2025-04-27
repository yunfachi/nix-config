{
  delib,
  decryptHostSecret,
  ...
}:
delib.host {
  name = "jakuzure";

  myconfig = {name, ...}: {
    programs.beets = {
      enable = true;

      directory = "/media/music";
      database = "/media/music_beets.db";

      subsonicUpdate = {
        enable = true;
        user = decryptHostSecret name "programs/beets/subsonic/user";
        pass = decryptHostSecret name "programs/beets/subsonic/pass";
      };
    };
  };
}
