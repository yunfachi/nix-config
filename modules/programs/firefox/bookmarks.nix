{
  module-functions,
  hm,
  ...
}:
module-functions.module "programs" "firefox" {
  hm.programs.firefox.profiles.dev-edition-default.bookmarks = [
    {
      toolbar = true;
      bookmarks = [
        {
          name = "yunfachi";
          url = "https://mail.google.com/mail/u/0/#inbox";
        }
        {
          name = "dg";
          url = "https://mail.google.com/mail/u/1/#inbox";
        }
        {
          name = "search";
          url = "https://search.nixos.org/options";
        }
        {
          name = "watch";
          url = "https://shikimori.one/yunfachi/list/anime?mylist=watching&order=rate_updated";
        }
        {
          name = "translate";
          url = "https://translate.yandex.ru/?source_lang=en&target_lang=ru";
        }
      ];
    }
  ];
}
