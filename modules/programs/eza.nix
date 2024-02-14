{
  module-functions,
  hm,
  ...
}:
module-functions.module "programs" "eza" (cfg: {
  hm.programs.eza = {
    enable = true;

    enableAliases = cfg.enableAliases;
    git = true;
    icons = cfg.icons;

    extraOptions = [
      "--hyperlink"
      "--no-permissions"
      "--no-user"
      "--no-time"
    ];
  };
})
