{delib, ...}:
delib.module {
  name = "programs.firefox";

  home.ifEnabled = {cfg, ...}: {
    programs.firefox.misc = {
      displayBookmarksInToolbar = "always";
      bookmarks = cfg.bookmarks ++ cfg.defaultBookmarks;
    };
  };
}
