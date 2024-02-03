{
  module-functions,
  hm,
  pkgs,
  ypkgs,
  username,
  ...
}:
module-functions.module "programs" "firefox" {
  hm.programs.firefox.profiles."${username}".settings = {
    "browser.newtabpage.activity-stream.feeds.topsites" = false;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.theme.toolbar-theme" = 0;
    "browser.uiCustomization.state" = builtins.toJSON {
      currentVersion = 20;
      dirtyAreaCache = ["nav-bar" "PersonalToolbar" "toolbar-menubar" "TabsToolbar"];
      newElementCount = 12;
      placements = {
        PersonalToolbar = ["personal-bookmarks"];
        TabsToolbar = ["tabbrowser-tabs" "alltabs-button"];
        nav-bar = ["back-button" "forward-button" "stop-reload-button" "urlbar-container" "downloads-button" "developer-button" "unified-extensions-button"];
        toolbar-menubar = ["menubar-items"];
        unified-extensions-area = [];
        widget-overflow-fixed-list = [];
      };
      seen = ["save-to-pocket-button" "developer-button" "profiler-button"];
    };
    "browser.urlbar.shortcuts.bookmarks" = false;
    "browser.urlbar.shortcuts.history" = false;
    "browser.urlbar.shortcuts.quickactions" = false;
    "browser.urlbar.shortcuts.tabs" = false;
    "browser.urlbar.suggest.engines" = false;
    "browser.urlbar.suggest.history" = false;
    "browser.urlbar.suggest.openpage" = false;
    "browser.urlbar.suggest.topsite" = false;
    "extensions.activeThemeID" = "coffee_theme_firefox";
    "extensions.pendingOperations" = true;
    "privacy.trackingprotection.enabled" = true;
  };
}
