{
  module-functions,
  hm,
  ...
}:
module-functions.module "programs" "firefox" (cfg: {
  hm.programs.firefox.profiles.dev-edition-default.bookmarks = [
    {
      toolbar = true;
      bookmarks = cfg.bookmarks;
    }
  ];
})
