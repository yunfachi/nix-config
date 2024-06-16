{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "firefox" {
    enable = enableOption "firefox" host.isDesktop;
    enableAliases = enableOption "firefox aliases" true;

    bookmarks =
      listOption "firefox bookmarks" [
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
          name = "translate";
          url = "https://translate.yandex.ru/?source_lang=en&target_lang=ru";
        }
      ]
      types.attrs;
  }
