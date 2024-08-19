{delib, ...}:
delib.module {
  name = "programs.schizofox";

  home.ifEnabled = {cfg, ...}: {
    programs.schizofox.misc = {
      displayBookmarksInToolbar = "always";
      bookmarks = cfg.bookmarks ++ cfg.defaultBookmarks;
    };
  };
}
