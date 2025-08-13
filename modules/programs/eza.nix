{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.eza";

  options.programs.eza = with delib; {
    enable = boolOption host.cliFeatured;
    icons = enumOption [ "auto" "always" "never" ] "auto";
  };

  home.ifEnabled =
    { cfg, ... }:
    {
      programs.eza = {
        enable = true;

        git = true;
        icons = cfg.icons;

        extraOptions = [
          "--hyperlink"
          "--no-time"
          "--group-directories-first"
        ];
      };
    };
}
