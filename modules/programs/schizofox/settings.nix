{delib, ...}:
delib.module {
  name = "programs.schizofox";

  home.ifEnabled.programs.schizofox.settings = {
    "extensions.activeThemeID" = "coffee_theme_firefox";
    "browser.theme.toolbar-theme" = 0;
    "browser.uiCustomization.state" = builtins.toJSON {
      currentVersion = 20;
      newElementCount = 23;
      dirtyAreaCache = ["nav-bar" "unified-extensions-area" "PersonalToolbar" "TabsToolbar" "widget-overflow-fixed-list" "toolbar-menubar"];
      seen = ["developer-button" "_0050e3fa-15cc-4fb6-9c73-7354489a810b_-browser-action" "ublock0_raymondhill_net-browser-action" "_a138007c-5ff6-4d10-83d9-0afaf0efbe5e_-browser-action"];
      placements = {
        nav-bar = ["back-button" "forward-button" "stop-reload-button" "urlbar-container" "unified-extensions-button" "fxa-toolbar-menu-button"];
        PersonalToolbar = ["personal-bookmarks"];
        TabsToolbar = ["tabbrowser-tabs" "alltabs-button"];
        toolbar-menubar = ["menubar-items"];
        unified-extensions-area = ["ublock0_raymondhill_net-browser-action" "_0050e3fa-15cc-4fb6-9c73-7354489a810b_-browser-action" "_a138007c-5ff6-4d10-83d9-0afaf0efbe5e_-browser-action"];
        widget-overflow-fixed-list = ["downloads-button" "developer-button" "firefox-view-button" "characterencoding-button"];
      };
    };
  };
}
