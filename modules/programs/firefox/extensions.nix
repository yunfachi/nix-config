{delib, ...}:
delib.module {
  name = "programs.firefox";

  home.ifEnabled.programs.firefox.extensions = {
    enableExtraExtensions = true;
    extraExtensions = {
      "uBlock0@raymondhill.net".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      "{e75d9f2d-9270-4f16-94e1-abd73c5174f8}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/deshiro/latest.xpi";
      "{0050e3fa-15cc-4fb6-9c73-7354489a810b}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/browser-mopidy-youtube/latest.xpi";
      "{0d48da55-7195-4662-aafc-934d90cb26c2}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/sepia-coffee-v1/latest.xpi";
      "{a138007c-5ff6-4d10-83d9-0afaf0efbe5e}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/history-cleaner/latest.xpi";
      "{6b733b82-9261-47ee-a595-2dda294a4d08}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/yomitan/latest.xpi";
    };
  };
}
