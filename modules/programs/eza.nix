{delib, ...}:
delib.module {
  name = "programs.eza";

  options = {myconfig, ...}: {
    programs.eza = with delib; {
      enable = boolOption true;
      icons = boolOption myconfig.fonts.enable;
    };
  };

  home.ifEnabled = {cfg, ...}: {
    programs.eza = {
      enable = true;

      git = true;
      icons = cfg.icons;

      extraOptions = [
        "--hyperlink"
        "--no-permissions"
        "--no-user"
        "--no-time"
        "--group-directories-first"
      ];
    };
  };
}
