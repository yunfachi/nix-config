{
  delib,
  inputs,
  host,
  ...
}:
delib.module {
  name = "programs.schizofox";

  options.programs.schizofox = with delib; {
    enable = boolOption host.guiFeatured;
    bookmarks = listOfOption attrs [];
    defaultBookmarks = listOfOption attrs [
      {
        Title = "yunfachi";
        URL = "https://mail.google.com/mail/u/0/#inbox";
        Placement = "toolbar";
      }
      {
        Title = "dg";
        URL = "https://mail.google.com/mail/u/1/#inbox";
        Placement = "toolbar";
      }
      {
        Title = "watch";
        URL = "https://shikimori.one/yunfachi/list/anime?mylist=watching&order=rate_updated";
        Placement = "toolbar";
      }
      {
        Title = "github";
        URL = "https://github.com";
        Placement = "toolbar";
      }
      {
        Title = "jisho";
        URL = "https://jisho.org";
        Placement = "toolbar";
      }
    ];
  };

  myconfig.ifEnabled = {
    xdg.mime.associations = let
      firefox = "Schizofox.desktop";
    in {
      "application/json" = [firefox];
      "application/pdf" = [firefox];
      "application/rdf+xml" = [firefox];
      "application/rss+xml" = [firefox];
      "application/x-extension-htm" = [firefox];
      "application/x-extension-html" = [firefox];
      "application/x-extension-shtml" = [firefox];
      "application/x-extension-xht" = [firefox];
      "application/x-extension-xhtml" = [firefox];
      "application/xhtml_xml" = [firefox];
      "application/xhtml+xml" = [firefox];
      "application/xml" = [firefox];
      "x-scheme-handler/about" = [firefox];
      "x-scheme-handler/http" = [firefox];
      "x-scheme-handler/https" = [firefox];
      "x-scheme-handler/unknown" = [firefox];
    };

    persist.user.directories = [".mozilla/firefox/schizo.default"];
  };

  home.always.imports = [inputs.schizofox.homeManagerModule];

  home.ifEnabled = {
    programs.schizofox = {
      enable = true;
      misc.drm.enable = true;
    };
  };
}
