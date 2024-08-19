{
  delib,
  inputs,
  host,
  ...
}:
delib.module {
  name = "programs.schizofox";

  options.programs.schizofox = with delib; {
    enable = boolOption host.isDesktop;
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
    ];
  };

  home.always.imports = [inputs.schizofox.homeManagerModule];

  home.ifEnabled = {
    programs.schizofox = {
      enable = true;
      misc.drm.enable = true;
    };
  };
}
