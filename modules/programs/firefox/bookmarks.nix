{delib, ...}:
delib.module {
  name = "programs.firefox";

  home.ifEnabled = {cfg, ...}: {
    programs.schizofox.misc = {
      displayBookmarksInToolbar = "always";
      bookmarks = cfg.bookmarks ++ cfg.defaultBookmarks;
    };
  };
}
