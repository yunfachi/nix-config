{ delib, ... }:
delib.module {
  name = "programs.librewolf";

  options.programs.librewolf = with delib; {
    bookmarks = listOfOption attrs [ ];
    defaultBookmarks = listOfOption attrs [
      {
        name = "yunfachi";
        url = "https://mail.google.com/mail/u/0/#inbox";
      }
      {
        name = "dg";
        url = "https://mail.google.com/mail/u/1/#inbox";
      }
      {
        name = "watch";
        url = "https://shikimori.one/yunfachi/list/anime?mylist=watching&order=rate_updated";
      }
      {
        name = "github";
        url = "https://github.com";
      }
      {
        name = "jisho";
        url = "https://jisho.org";
      }
    ];
  };

  home.ifEnabled =
    { cfg, ... }:
    {
      programs.librewolf.profiles.default.bookmarks = {
        force = true;
        settings = [
          {
            name = "test";
            toolbar = true;
            bookmarks = cfg.bookmarks ++ cfg.defaultBookmarks;
          }
        ];
      };
    };
}
